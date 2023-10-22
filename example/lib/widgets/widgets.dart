import 'package:flutter/material.dart';
import 'package:flutter_pangle_ads_example/router/router.dart';

// 构建 AppBar
AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text('$title (FlutterAds)'),
    actions: [
      // 去 Pro 页面
      IconButton(
        icon: Image.asset('images/pro.png'),
        onPressed: () => pushProPage(context),
      ),
    ],
  );
}
