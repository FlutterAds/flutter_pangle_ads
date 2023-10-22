import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';

import 'ads_config.dart';
import 'pages/home_page.dart';

void main() {
  // 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  setAdEvent();
  init().then((value) {
    if (value) {
      FlutterPangleAds.showSplashAd(
        AdsConfig.splashId,
        logo: AdsConfig.logo,
        timeout: 3.5,
      );
    }
  });

  // 启动
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

/// 初始化广告 SDK
Future<bool> init() async {
  bool result = await FlutterPangleAds.initAd(
    AdsConfig.appId,
    directDownloadNetworkType: [
      NetworkType.kNetworkStateMobile,
      NetworkType.kNetworkStateWifi,
    ],
  );
  debugPrint("广告SDK 初始化${result ? '成功' : '失败'}");

  // 打开个性化广告推荐
  FlutterPangleAds.setUserExtData(personalAdsType: '1');
  return result;
}

/// 设置广告监听
Future<void> setAdEvent() async {
  FlutterPangleAds.onEventListener((event) {
    debugPrint('adId:${event.adId} action:${event.action}');
    if (event is AdErrorEvent) {
      // 错误事件
      debugPrint(' errCode:${event.errCode} errMsg:${event.errMsg}');
    } else if (event is AdRewardEvent) {
      // 激励事件
      debugPrint(
          ' rewardType:${event.rewardType} rewardVerify:${event.rewardVerify} rewardAmount:${event.rewardAmount} rewardName:${event.rewardName} errCode:${event.errCode} errMsg:${event.errMsg} customData:${event.customData} userId:${event.userId}');
    }
    // 测试关闭 Banner（会员场景）
    if (event.action == AdEventAction.onAdClosed &&
        event.adId == AdsConfig.bannerId02) {
      debugPrint('仅会员可以关闭广告');
    }
  });
}
