//
//  AdRewardEvent.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/19.
//

#import "AdRewardEvent.h"
#import "AdEventAction.h"

@implementation AdRewardEvent
- (id)initWithAdId:(NSString *)adId transId:(NSString *)transId customData:(NSString *)customData userId:(NSString *)userId{
    self.adId=adId;
    self.action=onAdReward;
    self.transId=transId;
    self.customData=customData;
    self.userId=userId;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=[super toMap];
    NSMutableDictionary *errData=[[NSMutableDictionary alloc]initWithDictionary:data];
    [errData setObject:_transId forKey:@"transId"];
    [errData setObject:_customData forKey:@"customData"];
    [errData setObject:_userId forKey:@"userId"];
    return errData;
}
@end
