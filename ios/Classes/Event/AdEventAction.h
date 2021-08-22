//
//  AdEventAction.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/14.
//

#import <Foundation/Foundation.h>
// 广告事件操作
@interface AdEventAction : NSObject
// 广告错误
extern NSString * const onAdError;
// 广告加载成功
extern NSString * const onAdLoaded;
// 广告填充
extern NSString * const onAdPresent;
// 广告曝光
extern NSString * const onAdExposure;
// 广告关闭（计时结束或者用户点击关闭）
extern NSString * const onAdClosed;
// 广告点击
extern NSString * const onAdClicked;
// 广告跳过
extern NSString * const onAdSkip;
// 广告播放或计时完毕
extern NSString * const onAdComplete;
// 获得广告激励
extern NSString * const onAdReward;
@end
