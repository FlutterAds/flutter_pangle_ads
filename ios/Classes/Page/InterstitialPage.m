//
//  InterstitialPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "InterstitialPage.h"

@implementation InterstitialPage

- (void)dealloc
{
    NSLog(@"InterstitialPage dealloc");
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    NSLog(@"加载广告:%@",self.posId);
    int width = [call.arguments[@"width"] intValue];
    int height = [call.arguments[@"height"] intValue];
    
    self.iad=[[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.posId adSize:CGSizeMake(width, height)];
    self.iad.delegate=self;
    [self.iad loadAdData];
}

#pragma mark - BUNativeExpresInterstitialAdDelegate

- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    if(self.iad){
        [self.iad showAdFromRootViewController:self.mainWin.rootViewController];
    }
    // 发送广告事件
    [self sendEventAction:onAdPresent];
}

- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdExposure];
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClicked];
}

- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送广告事件
    [self sendEventAction:onAdClosed];
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"%s",__FUNCTION__);
    self.iad = nil;
}

- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
}

@end
