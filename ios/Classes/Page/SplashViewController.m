//
//  SplashViewController.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/9/12.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // logo 判断为空，则全屏展示
    bool fullScreenAd=[self.logo isKindOfClass:[NSNull class]]||[self.logo length]==0;
    // 计算大小
    CGSize size=[[UIScreen mainScreen] bounds].size;
    CGFloat width=size.width;
    CGFloat height=size.height;
    CGFloat adHeight=size.height;// 广告区域的高度
    self.splashView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,width,height)];
    // 非全屏设置 Logo
    if(!fullScreenAd){
        CGFloat logoHeight=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
        adHeight=height-logoHeight;// 广告区域的高度
        // 设置底部 logo
        UIImageView *logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.logo]];
        logoView.frame=CGRectMake(0, adHeight, width, logoHeight);
        logoView.contentMode=UIViewContentModeCenter;
        // 防止点击 Logo 区域触发 Flutter 层的事件
        logoView.userInteractionEnabled=false;
        [self.splashView addSubview:logoView];
    }
    // 广告区域大小
    CGRect frame = CGRectMake(0,0,width,adHeight);
    self.splashAd=[[BUSplashAdView alloc] initWithSlotID:self.posId frame:frame];
    self.splashAd.tolerateTimeout=self.timeout;
    self.splashAd.delegate=self;
    // 加载全屏广告
    [self.splashAd loadAdData];
    //    // 设置广告 View
    [self.splashView addSubview:self.splashAd];
    [self.view addSubview:self.splashView];
    self.splashAd.rootViewController=self;
}

// 销毁页面
- (void) dismissPage{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - BUSplashAdDelegate

- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdLoaded];
    
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdClosed];
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdClicked];
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
    // 发送广告事件
    [self.sp sendEventAction:onAdSkip];
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
    // 发送广告错误事件
    [self.sp sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdExposure];
}

- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType{
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
    // 发送广告事件
    [self.sp sendEventAction:onAdComplete];
}


@end
