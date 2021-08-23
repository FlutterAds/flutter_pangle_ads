//
//  InterstitialPage.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"

// 插屏广告
@interface InterstitialPage : BaseAdPage<BUNativeExpresInterstitialAdDelegate>
@property (nonatomic, strong) BUNativeExpressInterstitialAd *iad;
@end
