//
//  RewardVideoPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/19.
//

#import "RewardVideoPage.h"

@implementation RewardVideoPage
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    self.customData = call.arguments[@"customData"] ;
    self.userId = call.arguments[@"userId"];
    // 初始化激励视频广告
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.extra=self.customData;
    model.userId=self.userId;
    self.rvad=[[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:self.posId rewardedVideoModel:model];
    self.rvad.delegate=self;
    [self.rvad loadAdData];
}


#pragma mark - BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    if(self.rvad){
        [self.rvad showAdFromRootViewController:self.rootController];
    }
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpressRewardedVideoAdCallback:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd withType:(BUNativeExpressRewardedVideoAdType)nativeExpressVideoType{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdPresent];
    
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    self.rvad=nil;
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdSkip];
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s",__FUNCTION__);
    if(error){
        // 发送广告错误事件
        [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
    }else{
        // 发送广告事件
        [self sendEventAction:onAdComplete];
    }
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@",[NSString stringWithFormat:@"verify:%@ rewardName:%@ rewardMount:%ld",verify?@"true":@"false",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount]);
    BURewardedVideoModel *model=rewardedVideoAd.rewardedVideoModel;
    // 发送激励事件
    AdRewardEvent *rewardEvent=[[AdRewardEvent alloc] initWithAdId:self.posId rewardVerify:verify rewardAmount:model.rewardAmount rewardName:model.rewardName customData:self.customData userId:self.userId errCode:0 errMsg:@""];
    [self sendEvent:rewardEvent];
    
    
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError * _Nullable)error {
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@"%@",[NSString stringWithFormat:@"rewardName:%@ rewardMount:%ld error:%@",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount,error]);
    // 发送激励事件
    BURewardedVideoModel *model=rewardedVideoAd.rewardedVideoModel;
    AdRewardEvent *rewardEvent=[[AdRewardEvent alloc] initWithAdId:self.posId rewardVerify:NO rewardAmount:model.rewardAmount rewardName:model.rewardName customData:self.customData userId:self.userId errCode:error.code  errMsg:error.localizedDescription];
    [self sendEvent:rewardEvent];
}

- (void)nativeExpressRewardedVideoAdDidCloseOtherController:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
}

@end
