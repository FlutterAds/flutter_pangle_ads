//
//  AdErrorEvent.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/13.
//

#import "AdErrorEvent.h"
#import "AdEventAction.h"

@implementation AdErrorEvent

- (id)initWithAdId:(NSString *)adId errCode:(NSNumber *)errCode errMsg:(NSString *)errMsg{
    self.adId=adId;
    self.action=onAdError;
    self.errCode=errCode;
    self.errMsg=errMsg;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=[super toMap];
    NSMutableDictionary *errData=[[NSMutableDictionary alloc]initWithDictionary:data];
    [errData setObject:_errMsg forKey:@"errMsg"];
    [errData setObject:_errCode forKey:@"errCode"];
    
    return errData;
}
@end
