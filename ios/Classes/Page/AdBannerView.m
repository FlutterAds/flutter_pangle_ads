//
//  AdBannerView.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/31.
//

#import "AdBannerView.h"
// Banner 广告 View
@interface AdBannerView()<FlutterPlatformView,BUNativeExpressBannerViewDelegate>
@property (strong,nonatomic) BUNativeExpressBannerView *bannerView;
@end
// Banner 广告 View
@implementation AdBannerView
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
                       plugin:(FlutterPangleAdsPlugin*) plugin{
    if (self = [super init]) {
        self.args=args;
        NSString* posId = args[kPosId];
        [self showAd:posId methodCall:nil eventSink:plugin.eventSink];
    }
    return self;
}

- (UIView*)view {
    return self.bannerView;
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    // 刷新间隔
    int interval=[self.args[@"interval"] intValue];
    int width = [self.args[@"width"] intValue];
    int height = [self.args[@"height"] intValue];
    
    self.bannerView=[[BUNativeExpressBannerView alloc] initWithSlotID:self.posId rootViewController:self.mainWin.rootViewController adSize:CGSizeMake(width, height) interval:interval];
    self.bannerView.delegate=self;
    [self.bannerView loadAdData];
}


#pragma mark BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
//    [self.delegate customEventBannerWasClicked:self];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    NSLog(@"%s",__FUNCTION__);
//    [self.delegate customEventBannerDidDismissModal:self];
}


//#pragma mark - BUNativeExpresInterstitialAdDelegate
//
//- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告事件
//    [self sendEventAction:onAdLoaded];
//}
//
//- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告错误事件
//    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
//}
//
//- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    if(self.iad){
//        [self.iad showAdFromRootViewController:self.mainWin.rootViewController];
//    }
//    // 发送广告事件
//    [self sendEventAction:onAdPresent];
//}
//
//- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告错误事件
//    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
//}
//
//- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告事件
//    [self sendEventAction:onAdExposure];
//}
//
//- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告事件
//    [self sendEventAction:onAdClicked];
//}
//
//- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    // 发送广告事件
//    [self sendEventAction:onAdClosed];
//}
//
//- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
//    NSLog(@"%s",__FUNCTION__);
//    self.iad = nil;
//}
//
//- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
//    NSLog(@"%s",__FUNCTION__);
//}

@end
