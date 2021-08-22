//
//  InterstitialPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"
#import "GDTUnifiedInterstitialAd.h"
// 插屏广告
@interface InterstitialPage : BaseAdPage<GDTUnifiedInterstitialAdDelegate>
@property (nonatomic, strong) GDTUnifiedInterstitialAd *iad;
@end
