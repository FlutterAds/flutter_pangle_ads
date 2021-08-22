//
//  SplashPage.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"
// 开屏广告
@interface SplashPage : BaseAdPage <BUSplashAdDelegate>
@property (strong, nonatomic) BUSplashAdView *splashAd;
@property (strong, nonatomic) UIView *bottomView;
@property (nonatomic, assign) BOOL fullScreenAd;
@end
