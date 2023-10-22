import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart';

import '../ads_config.dart';
import '../widgets/widgets.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Banner广告'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    );
  }
}
