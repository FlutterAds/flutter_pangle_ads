#import <Flutter/Flutter.h>
#import <BUAdSDK/BUAdSDK.h>
#import "SplashPage.h"
#import "InterstitialPage.h"
#import "RewardVideoPage.h"
#import "FullScreenVideoPage.h"

@interface FlutterPangleAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
@property (strong,nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) SplashPage *sad;
@property (strong, nonatomic) InterstitialPage *iad;
@property (strong, nonatomic) RewardVideoPage *rvad;
@property (strong,nonatomic) FullScreenVideoPage *fsad;
@property (weak,nonatomic) NSString *posId;

extern NSString *const kPosId;
extern NSString *const kAdBannerViewId;
@end
