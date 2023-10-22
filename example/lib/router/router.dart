import 'package:flutter/material.dart';

import '../pages/pro_page.dart';

// 去对应的页面
void pushPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

// 去 Pro 页面
void pushProPage(BuildContext context) {
  pushPage(context, ProPage());
}
