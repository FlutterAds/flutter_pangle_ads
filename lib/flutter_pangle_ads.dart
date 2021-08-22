import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'event/ad_event_handler.dart';
export 'event/ad_event_handler.dart';

/// 穿山甲广告插件
class FlutterPangleAds {
  // 方法通道
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_pangle_ads');
  // 事件通道
  static const EventChannel _eventChannel =
      const EventChannel('flutter_pangle_ads_event');

  /// 请求应用跟踪透明度授权
  static Future<bool> get requestIDFA async {
    if (Platform.isIOS) {
      final bool result = await _methodChannel.invokeMethod('requestIDFA');
      return result;
    }
    return true;
  }

  /// 初始化广告
  /// [appId] 广告配置 appId
  static Future<bool> initAd(String appId) async {
    final bool result = await _methodChannel.invokeMethod(
      'initAd',
      {'appId': appId},
    );
    return result;
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 展示如果传递则展示底部logo，不传递不展示，则全屏
  static Future<bool> showSplashAd(String posId, [String logo]) async {
    final bool result = await _methodChannel.invokeMethod(
      'showSplashAd',
      {
        'posId': posId,
        'logo': logo,
      },
    );
    return result;
  }

  /// 展示插屏广告
  /// [posId] 广告位 id
  /// [showPopup] Popup 形式显示（仅 Android）
  /// [autoPlayOnWifi] 是否仅在 WiFi 网络下自动播放
  /// [autoPlayMuted] 自动播放是否静音
  /// [detailPageMuted] 详情页是否静音
  static Future<bool> showInterstitialAd(
    String posId, {
    bool showPopup = false,
    bool autoPlayOnWifi = false,
    bool autoPlayMuted = true,
    bool detailPageMuted = false,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showInterstitialAd',
      {
        'posId': posId,
        'showPopup': showPopup,
        'autoPlayOnWifi': autoPlayOnWifi,
        'autoPlayMuted': autoPlayMuted,
        'detailPageMuted': detailPageMuted,
      },
    );
    return result;
  }

  /// 展示激励视频广告
  /// [posId] 广告位 id
  /// [playMuted] 是否静音播放
  /// [customData] 设置服务端验证的自定义信息
  /// [userId] 设置服务端验证的用户信息
  static Future<bool> showRewardVideoAd(
    String posId, {
    bool playMuted = false,
    String customData,
    String userId,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'showRewardVideoAd',
      {
        'posId': posId,
        'playMuted': playMuted,
        'customData': customData,
        'userId': userId,
      },
    );
    return result;
  }

  static Future<String> get platformVersion async {
    final String version =
        await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
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
