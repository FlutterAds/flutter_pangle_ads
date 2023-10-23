import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads_example/pages/banner_page.dart';
import 'package:flutter_pangle_ads_example/pages/splash_page.dart';
import 'package:flutter_pangle_ads_example/router/router.dart';
import 'package:flutter_pangle_ads_example/theme/style.dart';
import 'feed_page.dart';

import 'fullscreen_video_page.dart';
import 'reward_video_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                InkWell(
                  child: Image.asset(
                    'images/gromore_pro.png',
                    width: double.maxFinite,
                  ),
                  onTap: () => pushProPage(context),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('📢 请求应用跟踪透明授权(iOS)'),
                  onTap: () => requestIDFA(),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('📱 请求相关权限（Android）'),
                  onTap: () => requestPermissionIfNecessary(),
                ),
                kDivider,
                ListTile(
                  title: Text('开屏广告'),
                  onTap: () => pushPage(context, SplashPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('新插屏广告'),
                  onTap: () => pushPage(context, FullScreenVideoPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('Banner 广告'),
                  onTap: () => pushPage(context, BannerPage()),
                ),
                kDivider,
                ListTile(
                  dense: true,
                  title: Text('🚀 GroMore Pro 版'),
                  onTap: () => pushProPage(context),
                ),
                kDivider,
                ListTile(
                  title: Text('激励视频广告'),
                  onTap: () => pushPage(context, RewardVideoPage()),
                ),
                kDivider,
                ListTile(
                  title: Text('信息流'),
                  onTap: () => pushPage(context, FeedPage()),
                ),
                kDivider,
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
    print('请求广告标识符:$result');
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestPermissionIfNecessary() async {
    bool result = await FlutterPangleAds.requestPermissionIfNecessary;
    print('请求相关权限:$result');
  }
}
