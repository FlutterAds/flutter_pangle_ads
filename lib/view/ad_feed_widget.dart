import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Feed 信息流广告组件
/// 建议在个性化模板的广告view中，宽度自动铺满整个view，期望模板尺寸的参数设置中，高度可以设置为0，高度会自适应，达到最佳的展示比例
class AdFeedWidget extends StatefulWidget {
  AdFeedWidget({
    Key? key,
    required this.posId,
    this.show = true,
    this.width = 375,
    this.height = 128,
  }) : super(key: key);
  // 返回的广告 id，这里不是广告位id
  final String posId;
  // 是否显示广告
  final bool show;
  // 宽高
  final double width, height;

  @override
  _AdFeedWidgetState createState() => _AdFeedWidgetState();
}

class _AdFeedWidgetState extends State<AdFeedWidget>
    with AutomaticKeepAliveClientMixin {
  // View 类型
  final String viewType = 'flutter_pangle_ads_feed';
  // 创建参数
  late Map<String, dynamic> creationParams;
  // 通道
  late MethodChannel _channel;
  // 宽高
  double width = 375, height = 128;

  @override
  void initState() {
    this.width = widget.width;
    this.height = widget.height;
    creationParams = <String, dynamic>{
      "posId": widget.posId,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!widget.show || width <= 0 || height <= 0) {
      return SizedBox.shrink();
    }
    Widget view;
    if (Platform.isIOS) {
      view = UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (id) {
          _channel = MethodChannel('$viewType/$id');
          _channel.setMethodCallHandler(onMethodCallHandler);
        },
      );
    } else {
      view = AndroidView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (id) {
          _channel = MethodChannel('$viewType/$id');
          _channel.setMethodCallHandler(onMethodCallHandler);
        },
      );
    }
    // 有宽高信息了（渲染成功了）设置对应宽高
    return SizedBox.fromSize(
      size: Size(width, height),
      child: view,
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> onMethodCallHandler(MethodCall call) async {
    String method = call.method;
    // 设置大小
    if (method == 'setSize') {
      width = call.arguments['width'] ?? 0;
      height = call.arguments['height'] ?? 0;
      setState(() {});
    }
  }
}
