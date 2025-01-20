import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pangle_ads_method_channel.dart';
import 'event/ad_event_handler.dart';

abstract class FlutterPangleAdsPlatform extends PlatformInterface {
  FlutterPangleAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPangleAdsPlatform _instance = MethodChannelFlutterPangleAds();

  static FlutterPangleAdsPlatform get instance => _instance;

  static set instance(FlutterPangleAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 请求应用跟踪透明度授权(仅 iOS)
  Future<bool> requestIDFA() {
    throw UnimplementedError('requestIDFA() has not been implemented.');
  }

  /// 动态请求相关权限（仅 Android）
  Future<bool> requestPermissionIfNecessary() {
    throw UnimplementedError(
        'requestPermissionIfNecessary() has not been implemented.');
  }

  /// 初始化广告
  /// [appId] 应用ID
  /// [useTextureView] (Android) 是否使用TextureView控件播放视频
  /// [supportMultiProcess] (Android) 是否支持多进程
  /// [allowShowNotify] (Android) 是否允许sdk展示通知栏提示
  /// [directDownloadNetworkType] 允许直接下载的网络类型，默认是空会有下载确认提示，非空不会有提示
  Future<bool> initAd(
    String appId, {
    bool useTextureView = false,
    bool supportMultiProcess = false,
    bool allowShowNotify = true,
    List<int> directDownloadNetworkType = const [],
  }) {
    throw UnimplementedError('initAd() has not been implemented.');
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
  /// [timeout] 加载超时时间
  Future<bool> showSplashAd(String posId,
      {String? logo, double timeout = 3.5}) {
    throw UnimplementedError('showSplashAd() has not been implemented.');
  }

  /// 展示激励视频广告
  /// [posId] 广告位 id
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  Future<bool> showRewardVideoAd(String posId,
      {String? customData, String? userId}) {
    throw UnimplementedError('showRewardVideoAd() has not been implemented.');
  }

  /// 展示全屏视频、新插屏广告
  /// [posId] 广告位 id
  Future<bool> showFullScreenVideoAd(String posId) {
    throw UnimplementedError(
        'showFullScreenVideoAd() has not been implemented.');
  }

  /// 加载信息流广告列表
  /// [posId] 广告位 id
  /// [width] 宽度
  /// [height] 高度
  /// [count] 获取广告数量，建议 1~3 个
  Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) {
    throw UnimplementedError('loadFeedAd() has not been implemented.');
  }

  /// 清除信息流广告列表
  /// [list] 信息流广告 id 列表
  Future<bool> clearFeedAd(List<int> list) {
    throw UnimplementedError('clearFeedAd() has not been implemented.');
  }

  /// 事件回调
  Future<void> onEventListener(OnAdEventListener onAdEventListener) {
    throw UnimplementedError('onEventListener() has not been implemented.');
  }

  /// 设置个性化推荐
  /// @params personalAdsType,不传或传空或传非01值没任何影响,默认不屏蔽, 0屏蔽个性化推荐广告, 1不屏蔽个性化推荐广告
  Future<void> setUserExtData({required String personalAdsType}) {
    throw UnimplementedError('setUserExtData() has not been implemented.');
  }
}
