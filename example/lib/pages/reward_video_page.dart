import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';

import '../ads_config.dart';
import '../theme/style.dart';

// 激励视频
class RewardVideoPage extends StatefulWidget {
  const RewardVideoPage({Key? key}) : super(key: key);

  @override
  _RewardVideoPageState createState() => _RewardVideoPageState();
}

class _RewardVideoPageState extends State<RewardVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('激励视频(FlutterAds)'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('激励视频'),
            onTap: () => showRewardVideoAd(AdsConfig.rewardVideoId),
          ),
          kDivider,
          ListTile(
            title: Text('激励视频-二次进阶'),
            onTap: () => showRewardVideoAd(AdsConfig.rewardInteractVideoId),
          ),
          kDivider,
        ],
      ),
    );
  }

  /// 展示激励视频广告
  /// [posId] 广告位id
  Future<void> showRewardVideoAd(String posId) async {
    bool result = await FlutterPangleAds.showRewardVideoAd(
      AdsConfig.rewardVideoId,
      customData: 'customData',
      userId: 'userId',
    );
    print("展示激励视频广告${result ? '成功' : '失败'}");
  }
}
