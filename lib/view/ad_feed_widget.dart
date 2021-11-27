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
    this.show = true,
  }) : super(key: key);
  // 返回的广告 id，这里不是广告位id
  final String posId;
  // 是否显示广告
  final bool show;

  @override
  _AdFeedWidgetState createState() => _AdFeedWidgetState();
}

class _AdFeedWidgetState extends State<AdFeedWidget>
    with AutomaticKeepAliveClientMixin {
  // View 类型
  final String viewType = 'flutter_pangle_ads_feed';
  // 创建参数
  Map<String, dynamic> creationParams;

  @override
  void initState() {
    creationParams = <String, dynamic>{
      "posId": widget.posId,
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

  @override
  bool get wantKeepAlive => true;
}
