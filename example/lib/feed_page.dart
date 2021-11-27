import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads/view/ad_feed_widget.dart';
import 'package:flutter_pangle_ads_example/ads_config.dart';

/// 信息流页面
class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<int> feedList = [];

  @override
  void initState() {
    getFeedAdList();
    super.initState();
  }

  @override
  void dispose() {
    clearFeedAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQueryData.fromWindow(window).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index % 30 == 15) {
            if (feedList.isEmpty) {
              return Container(
                height: 60,
                width: double.maxFinite,
                color: Colors.teal,
                alignment: Alignment.centerLeft,
                child: Text('暂无广告 $index'),
              );
            }
            int adId = feedList[index ~/ 15 % feedList.length];
            // return AspectRatio(
            //   aspectRatio: 2.4,
            //   child: AdFeedWidget(
            //     posId: '$adId',
            //   ),
            // );
            return ConstrainedBox(
              constraints: BoxConstraints.loose(Size(375, 123)),
              child: AdFeedWidget(
                posId: '$adId',
              ),
            );
          }
          return Container(
            height: 60,
            width: double.maxFinite,
            color: Colors.teal,
            alignment: Alignment.centerLeft,
            child: Text('信息流 Item:$index'),
          );
        },
        itemCount: 100,
      ),
    );
  }

  // 加载信息流广告
  Future<void> getFeedAdList() async {
    try {
      List<int> adResultList =
          await FlutterPangleAds.loadFeedAd(AdsConfig.feedId01);
      feedList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  // 清除信息流广告
  Future<void> clearFeedAd() async {
    bool result = await FlutterPangleAds.clearFeedAd(feedList);
    print('clearFeedAd:$result');
  }
}
