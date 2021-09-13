//
//  SplashPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "SplashPage.h"
#import "SplashViewController.h"

@implementation SplashPage
// 加载广告
-(void)loadAd:(FlutterMethodCall *)call{
    NSString* logo=call.arguments[@"logo"];
    double timeout=[call.arguments[@"timeout"] doubleValue];
    // 开屏页面
    SplashViewController *svc=[[SplashViewController alloc] init];
    svc.posId=self.posId;
    svc.logo=logo;
    svc.timeout=timeout;
    svc.sp=self;
    //设置全屏
    svc.modalPresentationStyle = UIModalPresentationFullScreen;
    // 跳转页面
    [self.rootController presentViewController:svc animated:NO completion:^{
        
    }];
    
}

@end
