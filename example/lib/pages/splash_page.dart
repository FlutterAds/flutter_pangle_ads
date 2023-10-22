import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads_example/theme/style.dart';

import '../ads_config.dart';
import '../widgets/widgets.dart';

// 开屏
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, '开屏广告'),
      body: Column(
        children: [
          ListTile(
            title: Text('开屏（全屏）'),
            onTap: () => showSplashAd(),
          ),
          kDivider,
          ListTile(
            title: Text('开屏-Logo1'),
            onTap: () => showSplashAd(AdsConfig.logo),
          ),
          kDivider,
          ListTile(
            title: Text('开屏-Logo2'),
            onTap: () => showSplashAd(AdsConfig.logo2),
          ),
          kDivider,
        ],
      ),
    );
  }

  /// 展示开屏广告
  /// [logo] 展示如果传递则展示logo，不传递不展示
  Future<void> showSplashAd([String? logo]) async {
    bool result = await FlutterPangleAds.showSplashAd(
      AdsConfig.splashId,
      logo: logo,
      timeout: 3.5,
    );
    print("展示开屏广告${result ? '成功' : '失败'}");
  }
}
