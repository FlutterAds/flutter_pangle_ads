//
//  AdFeedView.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import "AdFeedView.h"
#import "FeedAdManager.h"

@interface AdFeedView()<FlutterPlatformView,BUNativeExpressAdViewDelegate>
@property (strong,nonatomic) BUNativeExpressAdManager *adManager;
@property (strong,nonatomic) UIView *feedView;

@end

@implementation AdFeedView

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger plugin:(FlutterPangleAdsPlugin *)plugin{
    if(self==[super init]){
        self.feedView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 128)];
        FlutterMethodCall *call= [FlutterMethodCall methodCallWithMethodName:@"AdFeedView" arguments:args];
        [self showAd:call eventSink:plugin.eventSink];
    }
    NSLog(@"%s %lli",__FUNCTION__,viewId);
    return self;
}

- (UIView *)view{
    return self.feedView;
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 处理消息
- (void) postMsghandler:(NSNotification*) notification{
    NSLog(@"%s postMsghandler name:%@ obj:%@",__FUNCTION__,notification.name,notification.object);
}

- (void)loadAd:(FlutterMethodCall *)call{
    NSNumber *key=[NSNumber numberWithInteger:[self.posId integerValue]];
    NSString *name=[NSString stringWithFormat:@"%@/%@", kAdFeedViewId, key.stringValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postMsghandler:) name:name object:nil];
    BUNativeExpressAdView *adView=[FeedAdManager.share getAd:key];
    adView.rootViewController=self.rootController;
    [self.feedView addSubview:adView];
    [adView render];
}

#pragma mark BUNativeExpressAdViewDelegate

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

@end
