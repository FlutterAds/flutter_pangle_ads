import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads_example/theme/style.dart';

import '../ads_config.dart';

// 全屏视频
class FullScreenVideoPage extends StatefulWidget {
  const FullScreenVideoPage({Key? key}) : super(key: key);

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('插屏广告(FlutterAds)'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('新插屏-全屏'),
            onTap: () => showFullScreenVideoAd(AdsConfig.newInterstitialId),
          ),
          kDivider,
          ListTile(
            title: Text('新插屏-半屏'),
            onTap: () => showFullScreenVideoAd(AdsConfig.newInterstitialId2),
          ),
          kDivider,
        ],
      ),
    );
  }

  /// 展示全屏视频、新插屏广告
  /// [posId] 广告位id
  Future<void> showFullScreenVideoAd(String posId) async {
    bool result = await FlutterPangleAds.showFullScreenVideoAd(posId);
    print("展示插屏广告${result ? '成功' : '失败'}");
  }
}
