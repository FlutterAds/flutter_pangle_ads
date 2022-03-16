import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'event/ad_event_handler.dart';

export 'event/ad_event_handler.dart';
export 'options/network_type.dart';
export 'view/ad_banner_widget.dart';
export 'view/ad_feed_widget.dart';

/// 穿山甲广告插件
class FlutterPangleAds {
  // 方法通道
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_pangle_ads');
  // 事件通道
  static const EventChannel _eventChannel =
      const EventChannel('flutter_pangle_ads_event');

  /// 请求应用跟踪透明度授权(仅 iOS)
  static Future<bool> get requestIDFA async {
    if (Platform.isIOS) {
      final bool result = await _methodChannel.invokeMethod('requestIDFA');
      return result;
    }
    return true;
  }

  /// 动态请求相关权限（仅 Android）
  static Future<bool> get requestPermissionIfNecessary async {
    if (Platform.isAndroid) {
      final bool result =
          await _methodChannel.invokeMethod('requestPermissionIfNecessary');
      return result;
    }
    return true;
  }

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
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'initAd',
      {
        'appId': appId,
        'useTextureView': useTextureView,
        'supportMultiProcess': supportMultiProcess,
        'allowShowNotify': allowShowNotify,
        'directDownloadNetworkType': directDownloadNetworkType,
      },
    );
    return result;
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
  /// [timeout] 加载超时时间
  /// [buttonType] 开屏广告的点击区域，1：全都可以点击 2：仅有下载 Bar 区域可以点击。具体参考：https://www.csjplatform.com/support/doc/611f0f0c1b039f004611e4da
  static Future<bool> showSplashAd(String posId,
      {String? logo, double timeout = 3.5, int buttonType = 1}) async {
    final bool result = await _methodChannel.invokeMethod(
      'showSplashAd',
      {
        'posId': posId,
        'logo': logo,
        'timeout': timeout,
        'buttonType': buttonType,
      },
    );
    return result;
  }

  /// 展示插屏广告
  /// [posId] 广告位 id
  /// [width] 请求模板广告素材的尺寸宽度（对应 expressViewWidth 参数）
  /// [height] 请求模板广告素材的尺寸高度（对应 expressViewWidth 参数）
  static Future<bool> showInterstitialAd(
    String posId, {
    int width = 300,
    int height = 300,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showInterstitialAd',
      {
        'posId': posId,
        'width': width,
        'height': height,
      },
    );
    return result;
  }

  /// 展示激励视频广告
  /// [posId] 广告位 id
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  static Future<bool> showRewardVideoAd(
    String posId, {
    String? customData,
    String? userId,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showRewardVideoAd',
      {
        'posId': posId,
        'customData': customData,
        'userId': userId,
      },
    );
    return result;
  }

  /// 展示全屏视频、新插屏广告
  /// [posId] 广告位 id
  static Future<bool> showFullScreenVideoAd(String posId) async {
    final bool result = await _methodChannel.invokeMethod(
      'showFullScreenVideoAd',
      {
        'posId': posId,
      },
    );
    return result;
  }

  /// 加载信息流广告列表
  /// [posId] 广告位 id
  /// [width] 宽度
  /// [height] 高度
  /// [count] 获取广告数量，建议 1~3 个
  static Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) async {
    final List<dynamic> result = await _methodChannel.invokeMethod(
      'loadFeedAd',
      {
        'posId': posId,
        'width': width,
        'height': height,
        'count': count,
      },
    );
    return List<int>.from(result);
  }

  /// 清除信息流广告列表
  /// [list] 信息流广告 id 列表
  static Future<bool> clearFeedAd(List<int> list) async {
    final bool result = await _methodChannel.invokeMethod(
      'clearFeedAd',
      {
        'list': list,
      },
    );
    return result;
  }

  ///事件回调
  ///@params onData 事件回调
  static Future<void> onEventListener(
      OnAdEventListener onAdEventListener) async {
    _eventChannel.receiveBroadcastStream().listen((data) {
      hanleAdEvent(data, onAdEventListener);
    });
  }
}
