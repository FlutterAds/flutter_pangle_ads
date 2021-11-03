import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pangle_ads/view/ad_feed_widget.dart';
import 'package:flutter_pangle_ads_example/ads_config.dart';

/// 信息流页面
class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQueryData.fromWindow(window).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流'),
      ),
      body: ListView.builder(
        cacheExtent: size.height * 5,
        itemBuilder: (context, index) {
          if (index % 8 == 7) {
            double height = 150 + 2 * index.toDouble();
            height = height.clamp(150, 600);
            return Container(
              height: 300,
              child: AdFeedWidget(
                posId: AdsConfig.feedId,
                width: size.width.toInt(),
                height: 300,
              ),
            );
          } else {
            return Container(
              height: 40,
              width: double.maxFinite,
              child: Text('信息流 Item'),
            );
          }
        },
        itemCount: 50,
      ),
    );
  }
}
