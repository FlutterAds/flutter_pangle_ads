import 'ad_error_event.dart';
import 'ad_event_action.dart';
import 'ad_reward_event.dart';
export 'ad_error_event.dart';
export 'ad_event_action.dart';
export 'ad_reward_event.dart';

/// 广告事件
class AdEvent {
  AdEvent({this.adId, this.action});
  // 广告 id
  final String adId;
  // 操作
  final String action;

  /// 解析 AdEvent
  factory AdEvent.fromJson(Map<dynamic, dynamic> json) {
    String action = json['action'];
    if (action == AdEventAction.onAdError) {
      return AdErrorEvent.fromJson(json);
    } else if (action == AdEventAction.onAdReward) {
      return AdRewardEvent.fromJson(json);
    } else {
      return AdEvent(
        adId: json['adId'],
        action: action,
      );
    }
  }
}
