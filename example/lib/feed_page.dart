import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';
import 'package:flutter_pangle_ads/view/ad_feed_widget.dart';
import 'package:flutter_pangle_ads_example/ads_config.dart';
import 'package:loadany/loadany.dart';

/// 信息流页面
class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<int> feedList = [];
  List<int> feedAdList = [];

  LoadStatus loadStatus = LoadStatus.normal;

  @override
  void initState() {
    getFeedList();
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
        title: Text('信息流（FlutterAds）'),
      ),
      body: LoadAny(
        onLoadMore: () async {
          getFeedList();
        },
        status: loadStatus,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index % 10 == 4) {
                    int adIndex = index ~/ 10;
                    print('adIndex:$adIndex');
                    if (adIndex >= feedAdList.length) {
                      return Container(
                        height: 80,
                        width: double.maxFinite,
                        color: Colors.blueAccent,
                        alignment: Alignment.centerLeft,
                        child: Text('暂无广告 $index'),
                      );
                    }

                    int adId = feedAdList[adIndex];
                    return AdFeedWidget(
                      posId: '$adId',
                    );
                  }
                  return Container(
                    height: 80,
                    width: double.maxFinite,
                    color: Colors.teal,
                    alignment: Alignment.centerLeft,
                    child: Text('信息流 Item:$index'),
                  );
                },
                childCount: feedList.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 加载信息流
  Future<void> getFeedList() async {
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < 30; i++) {
      feedList.add(i);
    }
    getFeedAdList();
  }

  // 加载信息流广告
  Future<void> getFeedAdList() async {
    try {
      int feedIdIndex = feedAdList.length ~/ 3 % AdsConfig.feedIdList.length;
      print('feedIdIndex:$feedIdIndex');
      List<int> adResultList = await FlutterPangleAds.loadFeedAd(
        AdsConfig.feedIdList[feedIdIndex],
        count: 3,
      );
      feedAdList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loadStatus = LoadStatus.normal;
    });
  }

  // 清除信息流广告
  Future<void> clearFeedAd() async {
    bool result = await FlutterPangleAds.clearFeedAd(feedAdList);
    print('clearFeedAd:$result');
  }
}
