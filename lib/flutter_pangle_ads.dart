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
  /// [onlyWifiDirectDownload] (Android) 是否仅 WiFi 时允许直接下载
  static Future<bool> initAd(
    String appId, {
    bool useTextureView = false,
    bool supportMultiProcess = false,
    bool allowShowNotify = true,
    bool onlyWifiDirectDownload = false,
  }) async {
    final bool result = await _methodChannel.invokeMethod(
      'initAd',
      {
        'appId': appId,
        'useTextureView': useTextureView,
        'supportMultiProcess': supportMultiProcess,
        'allowShowNotify': allowShowNotify,
        'onlyWifiDirectDownload': onlyWifiDirectDownload,
      },
    );
    return result;
  }

  /// 展示开屏广告
  /// [posId] 广告位 id
  /// [logo] 展示如果传递则展示底部logo，不传递不展示Logo，则全屏展示
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
    String customData,
    String userId,
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

  ///事件回调
  ///@params onData 事件回调
  static Future<void> onEventListener(
      OnAdEventListener onAdEventListener) async {
    _eventChannel.receiveBroadcastStream().listen((data) {
      hanleAdEvent(data, onAdEventListener);
    });
  }
}
