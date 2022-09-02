import 'ad_event.dart';

/// 广告激励事件
class AdRewardEvent extends AdEvent {
  AdRewardEvent(
      {required this.rewardType,
      required this.rewardVerify,
      required this.rewardAmount,
      required this.rewardName,
      this.errCode,
      this.errMsg,
      this.customData,
      this.userId,
      required String adId,
      required String action})
      : super(adId: adId, action: action);
  // 奖励类型，0:基础奖励 >0:进阶奖励 。4400版本新增
  final int rewardType;
  // 奖励是否有效
  final bool rewardVerify;
  // 奖励数量
  final int rewardAmount;
  // 奖励名称
  final String rewardName;
  // 错误码
  final int? errCode;
  // 错误信息
  final String? errMsg;
  // 服务端验证的自定义信息
  final String? customData;
  // 服务端验证的用户信息
  final String? userId;
  // 解析 json 为激励事件对象
  factory AdRewardEvent.fromJson(Map<dynamic, dynamic> json) {
    return AdRewardEvent(
      adId: json['adId'],
      action: json['action'],
      rewardType: json['rewardType'],
      rewardVerify: json['rewardVerify'],
      rewardAmount: json['rewardAmount'],
      rewardName: json['rewardName'],
      errCode: json['errCode'],
      errMsg: json['errMsg'],
      customData: json['customData'],
      userId: json['userId'],
    );
  }
}
