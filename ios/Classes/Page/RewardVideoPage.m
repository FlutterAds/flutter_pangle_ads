//
//  RewardVideoPage.m
//  flutter_qq_ads
//
//  Created by zero on 2021/8/19.
//

#import "RewardVideoPage.h"

@implementation RewardVideoPage
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    BOOL playMuted=[call.arguments[@"playMuted"] boolValue];
    self.customData = call.arguments[@"customData"] ;
    self.userId = call.arguments[@"userId"];
    // 初始化激励视频广告
    self.rvad= [[GDTRewardVideoAd alloc] initWithPlacementId:self.posId];
    self.rvad.delegate=self;
    self.rvad.videoMuted=playMuted;
    //如果设置了服务端验证，可以设置serverSideVerificationOptions属性
    GDTServerSideVerificationOptions *ssv = [[GDTServerSideVerificationOptions alloc] init];
    ssv.userIdentifier = self.userId;
    ssv.customRewardString = self.customData;
    self.rvad.serverSideVerificationOptions = ssv;
    [self.rvad loadAd];
}


#pragma mark - GDTRewardVideoAdDelegate
- (void)gdt_rewardVideoAdDidLoad:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self.rvad showAdFromRootViewController:controller];
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdLoaded];
    [self addAdEvent:event];
}


- (void)gdt_rewardVideoAdVideoDidLoad:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)gdt_rewardVideoAdWillVisible:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdPresent];
    [self addAdEvent:event];
}

- (void)gdt_rewardVideoAdDidExposed:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"广告已曝光");
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdExposure];
    [self addAdEvent:event];
}

- (void)gdt_rewardVideoAdDidClose:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@"广告已关闭");
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClosed];
    [self addAdEvent:event];
}


- (void)gdt_rewardVideoAdDidClicked:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"广告已点击");
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClicked];
    [self addAdEvent:event];
}

- (void)gdt_rewardVideoAd:(GDTRewardVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"ERROR: %@", error);
    // 添加广告错误事件
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:error.code] errMsg:error.localizedDescription];
    [self addAdEvent:event];
}

- (void)gdt_rewardVideoAdDidRewardEffective:(GDTRewardVideoAd *)rewardedVideoAd info:(NSDictionary *)info {
    NSLog(@"%s",__FUNCTION__);
    NSString *transId=[info objectForKey:@"GDT_TRANS_ID"];
    NSLog(@"播放达到激励条件 transid:%@", transId);
    AdRewardEvent *event=[[AdRewardEvent alloc] initWithAdId:self.posId transId:transId customData:self.customData userId:self.userId];
    [self addAdEvent:event];
}

- (void)gdt_rewardVideoAdDidPlayFinish:(GDTRewardVideoAd *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"视频播放结束");
}
@end
