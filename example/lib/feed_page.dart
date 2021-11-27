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
  Widget build(BuildContext context) {
    Size size = MediaQueryData.fromWindow(window).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流'),
      ),
      body: ListView.builder(
        // cacheExtent: size.height * 2,
        itemBuilder: (context, index) {
          if (index % 10 == 9) {
            if (feedList.isEmpty) {
              return Container(
                height: 60,
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                child: Text('信息流 Item:$index'),
              );
            }
            int adId = feedList[index ~/ 9 % feedList.length];
            return SizedBox(
              height: 284,
              child: AdFeedWidget(
                width: 375,
                height: 284,
                posId: '$adId',
              ),
            );
          }
          return Container(
            height: 60,
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            child: Text('信息流 Item:$index'),
          );
        },
        itemCount: 100,
      ),
    );
  }

  Future<void> getFeedAdList() async {
    try {
      List<int> adResultList =
          await FlutterPangleAds.loadFeedAd(AdsConfig.feedId);
      feedList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }
}
