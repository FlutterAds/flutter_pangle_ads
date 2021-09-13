import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';

import 'ads_config.dart';

// 结果信息
String _result = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _adEvent = '';

  @override
  void initState() {
    super.initState();
    init().then((value) {
      if (value) {
        showSplashAd(AdsConfig.logo);
      }
    });
    setAdEvent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterAds pangle plugin'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Result: $_result'),
                SizedBox(height: 10),
                Text('onAdEvent: $_adEvent'),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('初始化'),
                  onPressed: () {
                    init();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('请求应用跟踪透明度授权(仅 iOS)'),
                  onPressed: () {
                    requestIDFA();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('动态请求相关权限（仅 Android）'),
                  onPressed: () {
                    requestPermissionIfNecessary();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示开屏广告（Logo2）'),
                  onPressed: () {
                    showSplashAd(AdsConfig.logo2);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示开屏广告（全屏）'),
                  onPressed: () {
                    showSplashAd();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示插屏广告'),
                  onPressed: () {
                    showInterstitialAd();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示新插屏视频广告'),
                  onPressed: () {
                    showFullScreenVideoAd(AdsConfig.newInterstitialId);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示新插屏（半屏）广告'),
                  onPressed: () {
                    showFullScreenVideoAd(AdsConfig.newInterstitialId2);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示激励视频广告'),
                  onPressed: () {
                    showRewardVideoAd();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('展示全屏视频广告'),
                  onPressed: () {
                    showFullScreenVideoAd(AdsConfig.fullScreenVideoId);
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 150,
                  child: AdBannerWidget(
                    posId: AdsConfig.bannerId,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  height: 80,
                  child: AdBannerWidget(
                    posId: AdsConfig.bannerId01,
                    width: 300,
                    height: 75,
                    interval: 30,
                    show: true,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  height: 50,
                  child: AdBannerWidget(
                    posId: AdsConfig.bannerId02,
                    width: 320,
                    height: 50,
                    autoClose: false,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 初始化广告 SDK
  Future<bool> init() async {
    try {
      bool result = await FlutterPangleAds.initAd(
        AdsConfig.appId,
        directDownloadNetworkType: [
          NetworkType.kNetworkStateMobile,
          NetworkType.kNetworkStateWifi,
        ],
      );
      _result = "广告SDK 初始化${result ? '成功' : '失败'}";
      setState(() {});
      return result;
    } on PlatformException catch (e) {
      _result =
          "广告SDK 初始化失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
    return false;
  }

  /// 设置广告监听
  Future<void> setAdEvent() async {
    setState(() {
      _adEvent = '设置成功';
    });
    FlutterPangleAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is AdErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      } else if (event is AdRewardEvent) {
        // 激励事件
        _adEvent +=
            ' rewardVerify:${event.rewardVerify} rewardAmount:${event.rewardAmount} rewardName:${event.rewardName} errCode:${event.errCode} errMsg:${event.errMsg} customData:${event.customData} userId:${event.userId}';
      }
      // 测试关闭 Banner（会员场景）
      if (event.action == AdEventAction.onAdClosed &&
          event.adId == AdsConfig.bannerId02) {
        _adEvent += '仅会员可以关闭广告';
      }
      print('onEventListener:$_adEvent');
      setState(() {});
    });
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestIDFA() async {
    bool result = await FlutterPangleAds.requestIDFA;
    _adEvent = '请求广告标识符:$result';
    setState(() {});
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestPermissionIfNecessary() async {
    bool result = await FlutterPangleAds.requestPermissionIfNecessary;
    _adEvent = '请求相关权限:$result';
    setState(() {});
  }

  /// 展示开屏广告
  /// [logo] 展示如果传递则展示logo，不传递不展示
  Future<void> showSplashAd([String? logo]) async {
    try {
      bool result = await FlutterPangleAds.showSplashAd(
        AdsConfig.splashId,
        logo: logo,
        timeout: 3.5,
      );
      _result = "展示开屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示开屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
  }

  /// 展示插屏广告
  Future<void> showInterstitialAd() async {
    try {
      bool result = await FlutterPangleAds.showInterstitialAd(
        AdsConfig.interstitialId,
        width: 300,
        height: 300,
      );
      _result = "展示插屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示插屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }

  /// 展示激励视频广告
  Future<void> showRewardVideoAd() async {
    try {
      bool result = await FlutterPangleAds.showRewardVideoAd(
        AdsConfig.rewardVideoId,
        customData: 'customData',
        userId: 'userId',
      );
      _result = "展示激励视频广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result =
          "展示激励视频广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }

  /// 展示全屏视频广告
  Future<void> showFullScreenVideoAd(String posId) async {
    try {
      bool result = await FlutterPangleAds.showFullScreenVideoAd(
        posId,
      );
      _result = "展示全屏视频广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result =
          "展示全屏视频广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }
}
