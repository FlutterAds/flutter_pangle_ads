import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  // 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  // 启动
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
