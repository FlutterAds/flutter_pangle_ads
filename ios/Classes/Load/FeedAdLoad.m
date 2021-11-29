//
//  FeedAdLoad.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import "FeedAdLoad.h"
#import "FeedAdManager.h"
#import "FlutterPangleAdsPlugin.h"

@implementation FeedAdLoad

- (void)loadFeedAdList:(FlutterMethodCall *)call result:(FlutterResult)result eventSink:(FlutterEventSink)events{
    self.result=result;
    [self showAd:call eventSink:events];
}

- (void)loadAd:(FlutterMethodCall *)call{
        int width = [call.arguments[@"width"] intValue];
        int height = [call.arguments[@"height"] intValue];
        int count = [call.arguments[@"count"] intValue];
        
        BUAdSlot *slot= [[BUAdSlot alloc]init];
        slot.ID=self.posId;
        slot.AdType=BUAdSlotAdTypeFeed;
        BUSize *size=[BUSize sizeBy:BUProposalSize_Feed228_150];
        slot.imgSize=size;
        slot.position=BUAdSlotPositionFeed;
        if(!self.adManager){
            self.adManager= [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake(width, height)];
        }
        self.adManager.adSize=CGSizeMake(width, height);
        self.adManager.delegate=self;
        // 加载广告
        [self.adManager loadAdDataWithCount:count];
}

#pragma mark BUNativeExpressAdViewDelegate

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views{
    NSLog(@"%s",__FUNCTION__);
    if (views.count) {
        NSMutableArray *adList= [[NSMutableArray alloc] init];
        [views enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *key=[NSNumber numberWithInteger:[obj hash]];
            NSLog(@"FeedAdLoad idx:%i obj:%p hash:%i",[obj hash],obj,key);
            // 添加到返回列表中
            [adList addObject:key];
            [FeedAdManager.share putAd:key value:obj];
        }];
        self.result(adList);
    }
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdError forKey:@"event"]];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdExposure forKey:@"event"]];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdClicked forKey:@"event"]];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdExposure forKey:@"event"]];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewDidRemoved:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
    NSNumber *key=[NSNumber numberWithInteger:[nativeExpressAdView hash]];
    // 删除广告缓存
    [FeedAdManager.share removeAd:key];
    // 发送广告事件
    [self sendEventAction:onAdClosed];
    [self postNotificationMsg:nativeExpressAdView userInfo:[NSDictionary dictionaryWithObject:onAdClosed forKey:@"event"]];
}

// 发送消息
- (void) postNotificationMsg:(BUNativeExpressAdView *) adView userInfo:(NSDictionary *) userInfo{
    NSNumber *key=[NSNumber numberWithInteger:[adView hash]];
    NSString *name=[NSString stringWithFormat:@"%@/%@", kAdFeedViewId, key.stringValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:adView userInfo:userInfo];
}

@end
