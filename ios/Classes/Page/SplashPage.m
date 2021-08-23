//
//  SplashPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "SplashPage.h"

@implementation SplashPage
// 加载广告
-(void)loadAd:(FlutterMethodCall *)call{
    NSString* logo=call.arguments[@"logo"];
    // logo 判断为空，则全屏展示
    self.fullScreenAd=[logo isKindOfClass:[NSNull class]]||[logo length]==0;
    // 计算大小
    CGFloat adHeight=self.height;// 广告区域的高度
    // 非全屏设置 Logo
    if(!self.fullScreenAd){
        CGFloat logoHeight=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
        adHeight=self.height-logoHeight;// 广告区域的高度
        // 设置底部 logo
        self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, adHeight,self.width, logoHeight)];
        self.bottomView.backgroundColor=[UIColor whiteColor];
        UIImageView *logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:logo]];
        logoView.frame=CGRectMake(0, 0, self.width, logoHeight);
        logoView.contentMode=UIViewContentModeCenter;
        [self.bottomView addSubview:logoView];
    }
    // 广告区域大小
    CGRect frame = CGRectMake(0,0,self.width,adHeight);
    self.splashAd=[[BUSplashAdView alloc] initWithSlotID:self.posId frame:frame];
    self.splashAd.delegate=self;
    // 加载全屏广告
    [self.splashAd loadAdData];
    // 设置广告 View
    [self.mainWin.rootViewController.view addSubview:self.splashAd];
    self.splashAd.rootViewController=self.mainWin.rootViewController;
}

// 删除广告 View
- (void)removeSplashAdView {
    if (self.splashAd) {
        [self.splashAd removeFromSuperview];
        self.splashAd = nil;
    }
    // 底部 Logo
    if(self.bottomView){
        [self.bottomView removeFromSuperview];
        self.bottomView=nil;
    }
}

#pragma mark - BUSplashAdDelegate

- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self.mainWin.rootViewController.view addSubview:self.bottomView];
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
    
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [splashAd removeFromSuperview];
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // Be careful not to say 'self.splashadview = nil' here.
    // Subsequent agent callbacks will not be triggered after the 'splashAdView' is released early.
    [splashAd removeFromSuperview];
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self removeSplashAdView];
    // 发送广告事件
    [self sendEventAction:onAdSkip];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    [self removeSplashAdView];
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
    [self removeSplashAdView];
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
}

@end
