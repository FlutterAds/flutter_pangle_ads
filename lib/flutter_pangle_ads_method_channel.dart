import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'event/ad_event_handler.dart';
import 'flutter_pangle_ads_platform_interface.dart';

/// 基于方法通道的实现
class MethodChannelFlutterPangleAds extends FlutterPangleAdsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pangle_ads');

  @visibleForTesting
  final eventChannel = const EventChannel('flutter_pangle_ads_event');

  @override
  Future<bool> requestIDFA() async {
    if (Platform.isIOS) {
      final bool result = await methodChannel.invokeMethod('requestIDFA');
      return result;
    }
    return true;
  }

  @override
  Future<bool> requestPermissionIfNecessary() async {
    if (Platform.isAndroid) {
      final bool result =
          await methodChannel.invokeMethod('requestPermissionIfNecessary');
      return result;
    }
    return true;
  }

  @override
  Future<bool> initAd(
    String appId, {
    bool useTextureView = false,
    bool supportMultiProcess = false,
    bool allowShowNotify = true,
    List<int> directDownloadNetworkType = const [],
  }) async {
    final bool result = await methodChannel.invokeMethod(
      'initAd',
      {
        'appId': appId,
        'useTextureView': useTextureView,
        'supportMultiProcess': supportMultiProcess,
        'allowShowNotify': allowShowNotify,
        'directDownloadNetworkType': directDownloadNetworkType,
      },
    );
    print(
        "🎉🎉🎉 FlutterAds ==> 初始化完成，推荐使用 GroMore Pro 版本，获得更高的收益：https://flutterads.top/");
    return result;
  }

  @override
  Future<bool> showSplashAd(String posId,
      {String? logo, double timeout = 3.5}) async {
    final bool result = await methodChannel.invokeMethod(
      'showSplashAd',
      {
        'posId': posId,
        'logo': logo,
        'timeout': timeout,
      },
    );
    return result;
  }

  @override
  Future<bool> showRewardVideoAd(String posId,
      {String? customData, String? userId}) async {
    final bool result = await methodChannel.invokeMethod(
      'showRewardVideoAd',
      {
        'posId': posId,
        'customData': customData,
        'userId': userId,
      },
    );
    return result;
  }

  @override
  Future<bool> showFullScreenVideoAd(String posId) async {
    final bool result = await methodChannel.invokeMethod(
      'showFullScreenVideoAd',
      {
        'posId': posId,
      },
    );
    return result;
  }

  @override
  Future<List<int>> loadFeedAd(String posId,
      {int width = 375, int height = 0, int count = 1}) async {
    final List<dynamic> result = await methodChannel.invokeMethod(
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

  @override
  Future<bool> clearFeedAd(List<int> list) async {
    final bool result = await methodChannel.invokeMethod(
      'clearFeedAd',
      {
        'list': list,
      },
    );
    return result;
  }

  @override
  Future<void> onEventListener(OnAdEventListener onAdEventListener) async {
    eventChannel.receiveBroadcastStream().listen((data) {
      hanleAdEvent(data, onAdEventListener);
    });
  }

  @override
  Future<void> setUserExtData({required String personalAdsType}) async {
    await methodChannel.invokeMethod(
      'setUserExtData',
      {
        'personalAdsType': personalAdsType,
      },
    );
  }
}
