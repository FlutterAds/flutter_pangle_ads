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
@property (strong,nonatomic) BUNativeExpressAdView *adView;
@property (strong,nonatomic) FlutterMethodChannel *methodChannel;

@end

@implementation AdFeedView

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger plugin:(FlutterPangleAdsPlugin *)plugin{
    if(self==[super init]){
        self.viewId=viewId;
        self.feedView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 128)];
        self.methodChannel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@/%lli",kAdFeedViewId,viewId] binaryMessenger:messenger];
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
    NSString *name=notification.name;
    BUNativeExpressAdView *loadAdView=notification.object;
    NSDictionary *userInfo=notification.userInfo;
    NSString *event=[userInfo objectForKey:@"event"];
    if([event isEqualToString:onAdExposure]){
        // 渲染成功，设置高度
        CGSize size= loadAdView.frame.size;
        [self setFlutterViewSize:size];
    }else if([event isEqualToString:onAdClosed]){
        [self.adView removeFromSuperview];
        [self setFlutterViewSize:CGSizeZero];
    }
}
// 设置 FlutterAds 视图宽高
- (void) setFlutterViewSize:(CGSize) size{
    NSNumber *width=[NSNumber numberWithFloat:size.width];
    NSNumber *height=[NSNumber numberWithFloat:size.height];
    NSDictionary *dicSize=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:width,height, nil] forKeys:[NSArray arrayWithObjects:@"width",@"height", nil]];
    [self.methodChannel invokeMethod:@"setSize" arguments:dicSize];
}

- (void)loadAd:(FlutterMethodCall *)call{
    NSNumber *key=[NSNumber numberWithInteger:[self.posId integerValue]];
    NSString *name=[NSString stringWithFormat:@"%@/%@", kAdFeedViewId, key.stringValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postMsghandler:) name:name object:nil];
    self.adView=[FeedAdManager.share getAd:key];
    self.adView.rootViewController=self.rootController;
    [self.feedView addSubview:self.adView];
    [self.adView render];
}

@end
