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
    CGSize adSize = CGSizeMake(width,adHeight);
    // 广告数据构建
    
    self.splashAd=[[BUSplashAd alloc] initWithSlotID:self.posId adSize:adSize];
    self.splashAd.tolerateTimeout=self.timeout;
    self.splashAd.delegate=self;
    // 加载全屏广告
    [self.splashAd loadAdData];
}

// 销毁页面
- (void) dismissPage{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - BUSplashAdDelegate

- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd {
    [splashAd showSplashViewInRootViewController:self];
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdLoaded];
}

/// This method is called when material load failed
- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error{
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
    // 发送广告错误事件
    [self.sp sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

/// This method is called when splash view render successful
- (void)splashAdRenderSuccess:(BUSplashAd *)splashAd{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdExposure];
    //    // 设置广告 View
    [self.splashView addSubview:splashAd.splashView];
    [self.view addSubview:self.splashView];
}

/// This method is called when splash view render failed
- (void)splashAdRenderFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error{
    NSLog(@"%s",__FUNCTION__);
    [self dismissPage];
    // 发送广告错误事件
    [self.sp sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdClosed];
    [self dismissPage];
}


- (void)splashAdDidClick:(BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self.sp sendEventAction:onAdClicked];
    [self dismissPage];
}

//- (void)splashAdDidClickSkip:(BUSplashAd *)splashAd {
//    NSLog(@"%s",__FUNCTION__);
//    [self dismissPage];
//    // 发送广告事件
//    [self.sp sendEventAction:onAdSkip];
//}

//- (void)splashAdDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType{
//    NSLog(@"%s",__FUNCTION__);
//    [self dismissPage];
//}
//
//- (void)splashAdCountdownToZero:(BUSplashAd *)splashAd {
//    NSLog(@"%s",__FUNCTION__);
//    [self dismissPage];
//    // 发送广告事件
//    [self.sp sendEventAction:onAdComplete];
//}


@end
