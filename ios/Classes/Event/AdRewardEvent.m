//
//  AdRewardEvent.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/19.
//

#import "AdRewardEvent.h"
#import "AdEventAction.h"

@implementation AdRewardEvent
- (id)initWithAdId:(NSString *)adId rewardType:(NSInteger) rewardType rewardVerify:(BOOL) rewardVerify rewardAmount:(NSInteger) rewardAmount rewardName:(NSString *)rewardName customData:(NSString *)customData userId:(NSString *)userId errCode:(NSInteger) errCode errMsg:(NSString*) errMsg{
    self.rewardType=rewardType;
    self.adId=adId;
    self.action=onAdReward;
    self.rewardVerify=rewardVerify;
    self.rewardAmount=rewardAmount;
    self.rewardName=rewardName;
    self.customData=customData;
    self.userId=userId;
    self.errCode=errCode;
    self.errMsg=errMsg;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=[super toMap];
    NSMutableDictionary *errData=[[NSMutableDictionary alloc]initWithDictionary:data];
    [errData setObject:@(_rewardVerify) forKey:@"rewardVerify"];
    [errData setObject:[NSNumber numberWithInteger:_rewardAmount] forKey:@"rewardAmount"];
    [errData setObject:_rewardName forKey:@"rewardName"];
    [errData setObject:[NSNumber numberWithInteger: _errCode] forKey:@"errCode"];
    [errData setObject:_errMsg forKey:@"errMsg"];
    [errData setObject:_customData forKey:@"customData"];
    [errData setObject:_userId forKey:@"userId"];
    
    return errData;
}
@end
