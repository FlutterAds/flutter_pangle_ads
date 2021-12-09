import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// Banner 广告组件
class AdBannerWidget extends StatefulWidget {
  AdBannerWidget({
    Key? key,
    required this.posId,
    this.width = 300,
    this.height = 150,
    this.interval = 0,
    this.show = true,
    this.autoClose = true,
  }) : super(key: key);
  // 广告 id
  final String posId;
  // 创建 Banner 广告位时选择的宽度，默认值是 300
  final int width;
  // 创建 Banner 广告位时选择的高度，默认值是 150
  final int height;
  // 广告轮播间隔，0 或[30~120]之间的数字，单位为 s,默认为 0 不轮播
  final int interval;
  // 是否显示广告
  final bool show;
  // 是否自动关闭，一般是在用户点击不感兴趣之后的操作，可以在事件回调[AdEventAction.onAdClosed]中判断
  final bool autoClose;

  @override
  _AdBannerWidgetState createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget>
    with AutomaticKeepAliveClientMixin {
  // View 类型
  final String viewType = 'flutter_pangle_ads_banner';
  // 创建参数
  late Map<String, dynamic> creationParams;

  @override
  void initState() {
    creationParams = <String, dynamic>{
      "posId": widget.posId,
      "width": widget.width,
      "height": widget.height,
      "interval": widget.interval,
      "autoClose": widget.autoClose
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!widget.show) {
      return SizedBox.shrink();
    }
    if (Platform.isIOS) {
      return SizedBox.fromSize(
        size: Size(widget.width.toDouble(), widget.height.toDouble()),
        child: UiKitView(
          viewType: viewType,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return SizedBox.fromSize(
        size: Size(widget.width.toDouble(), widget.height.toDouble()),
        child: AndroidView(
          viewType: viewType,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
