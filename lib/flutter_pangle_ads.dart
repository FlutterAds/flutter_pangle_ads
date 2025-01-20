import 'dart:async';

import 'flutter_pangle_ads_platform_interface.dart';
import 'event/ad_event_handler.dart';

export 'event/ad_event_handler.dart';
export 'options/network_type.dart';
export 'view/ad_banner_widget.dart';
export 'view/ad_feed_widget.dart';

/// 穿山甲广告插件
class FlutterPangleAds {
  static FlutterPangleAdsPlatform get _platform =>
      FlutterPangleAdsPlatform.instance;

  /// 请求应用跟踪透明度授权(仅 iOS)
  static Future<bool> get requestIDFA => _platform.requestIDFA();

  /// 动态请求相关权限（仅 Android）
  static Future<bool> get requestPermissionIfNecessary =>
      _platform.requestPermissionIfNecessary();

  /// 初始化广告
  /// [appId] 应用ID
  /// [useTextureView] (Android) 是否使用TextureView控件播放视频
  /// [supportMultiProcess] (Android) 是否支持多进程
  /// [allowShowNotify] (Android) 是否允许sdk展示通知栏提示
  /// [directDownloadNetworkType] 允许直接下载的网络类型，默认是空会有下载确认提示，非空不会有提示
  static Future<bool> initAd(
    String appId, {
    bool useTextureView = false,
    bool supportMultiProcess = false,
    bool allowShowNotify = true,
    List<int> directDownloadNetworkType = const [],
  }) {
    return _platform.initAd(
      appId,
      useTextureView: useTextureView,
      supportMultiProcess: supportMultiProcess,
      allowShowNotify: allowShowNotify,
      directDownloadNetworkType: directDownloadNetworkType,
    );
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
  /// [timeout] 加载超时时间
  static Future<bool> showSplashAd(String posId,
      {String? logo, double timeout = 3.5}) {
    return _platform.showSplashAd(posId, logo: logo, timeout: timeout);
  }

  /// 展示激励视频广告
  /// [posId] 广告位 id
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  static Future<bool> showRewardVideoAd(
    String posId, {
    String? customData,
    String? userId,
  }) {
    return _platform.showRewardVideoAd(posId,
        customData: customData, userId: userId);
  }

  /// 展示全屏视频、新插屏广告
  /// [posId] 广告位 id
  static Future<bool> showFullScreenVideoAd(String posId) {
    return _platform.showFullScreenVideoAd(posId);
  }

  /// 加载信息流广告列表
  /// [posId] 广告位 id
  /// [width] 宽度
  /// [height] 高度
  /// [count] 获取广告数量，建议 1~3 个
  static Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) {
    return _platform.loadFeedAd(posId,
        width: width, height: height, count: count);
  }

  /// 清除信息流广告列表
  /// [list] 信息流广告 id 列表
  static Future<bool> clearFeedAd(List<int> list) {
    return _platform.clearFeedAd(list);
  }

  ///事件回调
  ///@params onData 事件回调
  static Future<void> onEventListener(OnAdEventListener onAdEventListener) {
    return _platform.onEventListener(onAdEventListener);
  }

  /// 设置个性化推荐
  /// @params personalAdsType,不传或传空或传非01值没任何影响,默认不屏蔽, 0屏蔽个性化推荐广告, 1不屏蔽个性化推荐广告
  static Future<void> setUserExtData({required String personalAdsType}) {
    return _platform.setUserExtData(personalAdsType: personalAdsType);
  }
}
