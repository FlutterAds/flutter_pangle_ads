import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Feed 信息流广告组件
/// 建议在个性化模板的广告view中，宽度自动铺满整个view，期望模板尺寸的参数设置中，高度可以设置为0，高度会自适应，达到最佳的展示比例
class AdFeedWidget extends StatefulWidget {
  AdFeedWidget({
    Key key,
    @required this.posId,
    this.width = 300,
    this.height = 0,
    this.show = true,
    this.autoClose = true,
  }) : super(key: key);
  // 广告 id
  final String posId;
  // 广告位的宽度，默认值是 300
  final int width;
  // 广告位的高度，默认值是 0，自适应
  final int height;
  // 是否显示广告
  final bool show;
  // 是否自动关闭，一般是在用户点击不感兴趣之后的操作，可以在事件回调[AdEventAction.onAdClosed]中判断
  final bool autoClose;

  @override
  _AdFeedWidgetState createState() => _AdFeedWidgetState();
}

class _AdFeedWidgetState extends State<AdFeedWidget> {
  // View 类型
  final String viewType = 'flutter_pangle_ads_feed';
  // 创建参数
  Map<String, dynamic> creationParams;

  @override
  void initState() {
    creationParams = <String, dynamic>{
      "posId": widget.posId,
      "width": widget.width,
      "height": widget.height,
      "autoClose": widget.autoClose
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) {
      return SizedBox.shrink();
    }
    if (Platform.isIOS) {
      return UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return AndroidView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }
}
