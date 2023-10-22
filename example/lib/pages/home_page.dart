import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads_example/theme/style.dart';
import 'feed_page.dart';

import '../ads_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result = '';
  String _adEvent = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterAds pangle plugin'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('请求应用跟踪透明授权(iOS)'),
                  onTap: () => requestIDFA(),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('请求相关权限（Android）'),
                  onTap: () => requestPermissionIfNecessary(),
                ),
                kDivider,
                ListTile(
                  title: Text('开屏广告（Logo2）'),
                  onTap: () => showSplashAd(AdsConfig.logo2),
                ),
                kDivider,
                ListTile(
                  title: Text('开屏广告（全屏）'),
                  onTap: () => showSplashAd(),
                ),
                kDivider,
                ListTile(
                  title: Text('新插屏视频广告'),
                  onTap: () =>
                      showFullScreenVideoAd(AdsConfig.newInterstitialId),
                ),
                kDivider,
                ListTile(
                  title: Text('新插屏（半屏）广告'),
                  onTap: () =>
                      showFullScreenVideoAd(AdsConfig.newInterstitialId2),
                ),
                kDivider,
                ListTile(
                  title: Text('激励视频广告'),
                  onTap: () => showRewardVideoAd(),
                ),
                kDivider,
                ListTile(
                  title: Text('激励视频广告（进阶）'),
                  onTap: () => showRewardVideoAd2(),
                ),
                kDivider,
                ListTile(
                  title: Text('信息流'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedPage(),
                        ));
                  },
                ),
                SizedBox(height: 20),
                AdBannerWidget(
                  posId: AdsConfig.bannerId,
                ),
                SizedBox(height: 10),
                AdBannerWidget(
                  posId: AdsConfig.bannerId01,
                  width: 300,
                  height: 75,
                  interval: 30,
                  show: true,
                ),
                SizedBox(height: 10),
                AdBannerWidget(
                  posId: AdsConfig.bannerId02,
                  width: 320,
                  height: 50,
                  autoClose: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  /// 展示激励视频广告（进阶）
  Future<void> showRewardVideoAd2() async {
    try {
      bool result = await FlutterPangleAds.showRewardVideoAd(
        AdsConfig.rewardInteractVideoId,
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
