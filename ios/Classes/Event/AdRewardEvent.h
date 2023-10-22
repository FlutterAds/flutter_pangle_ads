//
//  AdRewardEvent.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/19.
//

#import "BaseAdPage.h"
// 广告激励事件
@interface AdRewardEvent : AdEvent
// 激励类型
@property (nonatomic,assign) NSInteger rewardType;
// 奖励是否有效
@property BOOL rewardVerify;
// 奖励数量
@property (nonatomic,assign) NSInteger rewardAmount;
// 奖励名称
@property (copy,nonatomic) NSString *rewardName;
// 错误码
@property (nonatomic,assign) NSInteger errCode;
// 错误信息
@property (copy,nonatomic) NSString *errMsg;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
// 构造广告激励事件
-(id) initWithAdId:(NSString *)adId rewardType:(NSInteger) rewardType rewardVerify:(BOOL) rewardVerify rewardAmount:(NSInteger) rewardAmount rewardName:(NSString *)rewardName customData:(NSString *)customData userId:(NSString *)userId errCode:(NSInteger) errCode errMsg:(NSString*) errMsg;

@end
