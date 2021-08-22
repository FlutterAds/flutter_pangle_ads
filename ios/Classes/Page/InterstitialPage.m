//
//  InterstitialPage.m
//  flutter_qq_ads
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
    BOOL autoPlayMuted = [call.arguments[@"autoPlayMuted"] boolValue];
    BOOL autoPlayOnWifi = [call.arguments[@"autoPlayOnWifi"] boolValue];
    BOOL detailPageMuted = [call.arguments[@"detailPageMuted"] boolValue];
    
    self.iad=[[GDTUnifiedInterstitialAd alloc] initWithPlacementId:self.posId];
    self.iad.delegate=self;
    self.iad.videoAutoPlayOnWWAN=autoPlayOnWifi;
    self.iad.videoMuted=autoPlayMuted;
    self.iad.detailPageVideoMuted=detailPageMuted;
    [self.iad loadAd];
}

#pragma mark - GDTUnifiedInterstitialAdDelegate

/**
 *  插屏2.0广告预加载成功回调
 *  当接收服务器返回的广告数据成功后调用该函数
 */
- (void)unifiedInterstitialSuccessToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdLoaded];
    [self addAdEvent:event];
}

/**
 *  插屏2.0广告预加载失败回调
 *  当接收服务器返回的广告数据失败后调用该函数
 */
- (void)unifiedInterstitialFailToLoadAd:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"interstitial fail to load, Error : %@",error);
    // 添加广告错误事件
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:error.code] errMsg:error.localizedDescription];
    [self addAdEvent:event];
}


- (void)unifiedInterstitialDidDownloadVideo:(GDTUnifiedInterstitialAd *)unifiedInterstitial {
    NSLog(@"%s",__FUNCTION__);
}

- (void)unifiedInterstitialRenderSuccess:(GDTUnifiedInterstitialAd *)unifiedInterstitial {
    NSLog(@"%s",__FUNCTION__);
    UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self.iad presentAdFromRootViewController:controller];
}

- (void)unifiedInterstitialRenderFail:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    // 添加广告错误事件
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:error.code] errMsg:error.localizedDescription];
    [self addAdEvent:event];
}

/**
 *  插屏2.0广告将要展示回调
 *  插屏2.0广告即将展示回调该函数
 */
- (void)unifiedInterstitialWillPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)unifiedInterstitialFailToPresent:(GDTUnifiedInterstitialAd *)unifiedInterstitial error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告视图展示成功回调
 *  插屏2.0广告展示成功回调该函数
 */
- (void)unifiedInterstitialDidPresentScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdPresent];
    [self addAdEvent:event];
}

/**
 *  插屏2.0广告展示结束回调
 *  插屏2.0广告展示结束回调该函数
 */
- (void)unifiedInterstitialDidDismissScreen:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClosed];
    [self addAdEvent:event];
}

/**
 *  当点击下载应用时会调用系统程序打开
 */
- (void)unifiedInterstitialWillLeaveApplication:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  插屏2.0广告曝光回调
 */
- (void)unifiedInterstitialWillExposure:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdExposure];
    [self addAdEvent:event];
}

/**
 *  插屏2.0广告点击回调
 */
- (void)unifiedInterstitialClicked:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
    // 添加广告事件
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:onAdClicked];
    [self addAdEvent:event];
}

/**
 *  点击插屏2.0广告以后即将弹出全屏广告页
 */
- (void)unifiedInterstitialAdWillPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  点击插屏2.0广告以后弹出全屏广告页
 */
- (void)unifiedInterstitialAdDidPresentFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页将要关闭
 */
- (void)unifiedInterstitialAdWillDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  全屏广告页被关闭
 */
- (void)unifiedInterstitialAdDidDismissFullScreenModal:(GDTUnifiedInterstitialAd *)unifiedInterstitial
{
    NSLog(@"%s",__FUNCTION__);
}

@end
