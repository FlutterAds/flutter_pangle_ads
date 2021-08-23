import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';

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
      } else if (method == 'showInterstitialAd') {
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
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId, AdsConfig.logo),
      true,
    );
    expect(
      await FlutterPangleAds.showSplashAd(AdsConfig.splashId, AdsConfig.logo2),
      true,
    );
  });

  test('showInterstitialAd', () async {
    expect(
      await FlutterPangleAds.showInterstitialAd(AdsConfig.interstitialId),
      true,
    );
    expect(
      await FlutterPangleAds.showInterstitialAd(
        AdsConfig.interstitialId,
        expressViewWidth: 600,
        expressViewHeight: 600,
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
        AdsConfig.interstitialId,
        customData: 'FlutterAds',
        userId: '1024',
      ),
      true,
    );
  });
}
