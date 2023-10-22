import 'package:flutter/material.dart';

// 去对应的页面
void pushPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
