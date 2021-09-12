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
    double timeout=[call.arguments[@"timeout"] doubleValue];
    // logo 判断为空，则全屏展示
    self.fullScreenAd=[logo isKindOfClass:[NSNull class]]||[logo length]==0;
    // 计算大小
    CGFloat adHeight=self.height;// 广告区域的高度
    self.splashView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.width, self.height)];
    self.splashView.backgroundColor=[UIColor whiteColor];
    // 非全屏设置 Logo
    if(!self.fullScreenAd){
        CGFloat logoHeight=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
        adHeight=self.height-logoHeight;// 广告区域的高度
        // 设置底部 logo
        UIImageView *logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:logo]];
        logoView.frame=CGRectMake(0, adHeight, self.width, logoHeight);
        logoView.contentMode=UIViewContentModeCenter;
        // 防止点击 Logo 区域触发 Flutter 层的事件
        logoView.userInteractionEnabled=false;
        [self.splashView addSubview:logoView];
    }
    // 广告区域大小
    CGRect frame = CGRectMake(0,0,self.width,adHeight);
    self.splashAd=[[BUSplashAdView alloc] initWithSlotID:self.posId frame:frame];
    self.splashAd.tolerateTimeout=timeout;
    self.splashAd.delegate=self;
    // 加载全屏广告
    [self.splashAd loadAdData];
    // 设置广告 View
    [self.splashView addSubview:self.splashAd];
    [self.mainWin.rootViewController.view addSubview:self.splashView];
    self.splashAd.rootViewController=self.mainWin.rootViewController;
}

// 删除广告 View
- (void)removeSplashAdView {
    NSLog(@"%s",__FUNCTION__);
    // 底部 Logo
    if(self.splashView){
        [self.splashAd removeFromSuperview];
        self.splashAd=nil;
        [self.splashView removeFromSuperview];
        self.splashView=nil;
        
    }
}

#pragma mark - BUSplashAdDelegate

- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
    
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self removeSplashAdView];
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
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

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType{
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    if (!splashAd.zoomOutView) {
        [self removeSplashAdView];
    }
}

@end
