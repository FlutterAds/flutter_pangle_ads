import 'ad_event.dart';

/// 广告激励事件
class AdRewardEvent extends AdEvent {
  AdRewardEvent(
      {this.transId, this.customData, this.userId, String adId, String action})
      : super(adId: adId, action: action);
  // 激励服务端验证的唯一 ID
  final String transId;
  // 服务端验证的自定义信息
  final String customData;
  // 服务端验证的用户信息
  final String userId;
  // 解析 json 为激励事件对象
  factory AdRewardEvent.fromJson(Map<dynamic, dynamic> json) {
    return AdRewardEvent(
      adId: json['adId'],
      action: json['action'],
      transId: json['transId'],
      customData: json['customData'],
      userId: json['userId'],
    );
  }
}
