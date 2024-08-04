import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pro 版本
class ProPage extends StatefulWidget {
  const ProPage({Key? key}) : super(key: key);

  @override
  _ProPageState createState() => _ProPageState();
}

class _ProPageState extends State<ProPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gromore Pro 版本'),
        actions: [
          // 复制链接
          IconButton(
            icon: Icon(Icons.paste_rounded),
            onPressed: () => pasteUrl(),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => pasteUrl(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/gromore_1.png'),
              Image.asset('images/gromore_2.png'),
            ],
          ),
        ),
      ),
    );
  }

  /// 复制url
  Future<void> pasteUrl() async {
    Clipboard.setData(ClipboardData(text: 'https://flutterads.top/')).then(
        (value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('链接复制成功'))));
  }
}
