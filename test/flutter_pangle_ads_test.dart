import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ads_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_pangle_ads');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall call) async {
      String method = call.method;
      if (method == 'initAd') {
        return true;
      } else if (method == 'showSplashAd') {
        return true;
      } else if (method == 'showFullScreenVideoAd') {
        return true;
      } else if (method == 'showRewardVideoAd') {
        return true;
      } else {
        return false;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('initAd', () async {
    expect(await FlutterPangleAds.initAd(AdsConfig.appId), true);
  });

  test('showSplashAd', () async {
    expect(
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId),
      true,
    );
    expect(
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId,
          logo: AdsConfig.logo),
      true,
    );
    expect(
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId,
          logo: AdsConfig.logo2),
      true,
    );
    expect(
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId,
          logo: AdsConfig.logo2, timeout: 3.5),
      true,
    );
  });

  test('showFullScreenVideoAd', () async {
    expect(
      await FlutterPangleAds.showFullScreenVideoAd(AdsConfig.newInterstitialId),
      true,
    );
    expect(
      await FlutterPangleAds.showFullScreenVideoAd(
        AdsConfig.newInterstitialId2,
      ),
      true,
    );
  });

  test('showRewardVideoAd', () async {
    expect(
      await FlutterPangleAds.showRewardVideoAd(AdsConfig.rewardVideoId),
      true,
    );
    expect(
      await FlutterPangleAds.showRewardVideoAd(
        AdsConfig.rewardVideoId,
        customData: 'FlutterAds',
        userId: '1024',
      ),
      true,
    );
  });
}
