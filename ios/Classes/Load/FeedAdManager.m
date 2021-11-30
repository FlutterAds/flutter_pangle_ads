//
//  FeedAdManager.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import "FeedAdManager.h"

@interface FeedAdManager()
@property BUNativeExpressAdManager *adManager;// 广告管理对象

@end

@implementation FeedAdManager

static FeedAdManager *manager;
NSMutableDictionary *adList;// 已加载信息流广告列表


+ (instancetype)share{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        adList= [[NSMutableDictionary alloc]init];
        manager=[[FeedAdManager alloc] init];
    });
    return manager;
}

- (void)putAd:(NSNumber*)key value:(id)value{
    [adList setObject:value forKey:key];
}

- (id)getAd:(NSNumber*)key{
    return adList[key];
}

- (void)removeAd:(NSNumber*)key{
    [adList removeObjectForKey:key];
}



@end
