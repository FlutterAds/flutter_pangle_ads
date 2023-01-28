#import <Flutter/Flutter.h>
#import <BUAdSDK/BUAdSDK.h>
#import "SplashPage.h"
#import "RewardVideoPage.h"
#import "FullScreenVideoPage.h"
#import "FeedAdLoad.h"
#import "FeedAdManager.h"

@interface FlutterPangleAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
@property (strong,nonatomic) FlutterEventSink eventSink;
@property (strong, nonatomic) SplashPage *sad;
@property (strong, nonatomic) RewardVideoPage *rvad;
@property (strong,nonatomic) FullScreenVideoPage *fsad;
@property (strong,nonatomic) FeedAdLoad *fad;

extern NSString *const kAdBannerViewId;
extern NSString *const kAdFeedViewId;
@end
