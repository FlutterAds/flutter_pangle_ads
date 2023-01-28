#import "FlutterPangleAdsPlugin.h"
#import "NativeViewFactory.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@implementation FlutterPangleAdsPlugin
// AdBannerView
NSString *const kAdBannerViewId=@"flutter_pangle_ads_banner";
// AdFeedView
NSString *const kAdFeedViewId=@"flutter_pangle_ads_feed";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"flutter_pangle_ads"
                                           binaryMessenger:[registrar messenger]];
    FlutterEventChannel* eventChannel=[FlutterEventChannel eventChannelWithName:@"flutter_pangle_ads_event" binaryMessenger:[registrar messenger]];
    FlutterPangleAdsPlugin* instance = [[FlutterPangleAdsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    [eventChannel setStreamHandler:instance];
    // 注册平台View 工厂
    NativeViewFactory *bannerFactory=[[NativeViewFactory alloc] initWithViewName:kAdBannerViewId withMessenger:registrar.messenger withPlugin:instance];
    NativeViewFactory *feedFactory=[[NativeViewFactory alloc] initWithViewName:kAdFeedViewId withMessenger:registrar.messenger withPlugin:instance];
    // 注册 Banner View
    [registrar registerViewFactory:bannerFactory withId:kAdBannerViewId];
    // 注册 Feed View
    [registrar registerViewFactory:feedFactory withId:kAdFeedViewId];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *methodStr=call.method;
    if ([@"getPlatformVersion" isEqualToString:methodStr]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"requestIDFA" isEqualToString:methodStr]) {
        [self requestIDFA:call result:result];
    }else if ([@"initAd" isEqualToString:methodStr]) {
        [self initAd:call result:result];
    }else if([@"showSplashAd" isEqualToString:methodStr]) {
        [self showSplashAd:call result:result];
    }else if ([@"showRewardVideoAd" isEqualToString:methodStr]){
        [self showRewardVideoAd:call result:result];
    }else if ([@"showFullScreenVideoAd" isEqualToString:methodStr]){
        [self showFullScreenVideoAd:call result:result];
    }else if ([@"loadFeedAd" isEqualToString:methodStr]){
        [self loadFeedAd:call result:result];
    }else if ([@"clearFeedAd" isEqualToString:methodStr]){
        [self clearFeedAd:call result:result];
    }else if ([@"setUserExtData" isEqualToString:methodStr]){
        [self setUserExtData:call];
    }else {
        result(FlutterMethodNotImplemented);
    }
}

// 请求 IDFA
- (void) requestIDFA:(FlutterMethodCall*) call result:(FlutterResult) result{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            BOOL requestResult=status == ATTrackingManagerAuthorizationStatusAuthorized;
            NSLog(@"requestIDFA:%@",requestResult?@"YES":@"NO");
            result(@(requestResult));
        }];
    } else {
        result(@(YES));
    }
}

// 初始化广告
- (void) initAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSString* appId=call.arguments[@"appId"];
    BUAdSDKConfiguration *config = [BUAdSDKConfiguration configuration];
    config.appID=appId;
    [BUAdSDKManager startWithSyncCompletionHandler:^(BOOL success, NSError *error) {
        NSLog(@"initAd:%@",success?@"YES":@"NO");
        result(@(success));
    }];
}

// 显示开屏广告
- (void) showSplashAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.sad=[[SplashPage alloc] init];
    [self.sad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 显示激励视频广告
- (void) showRewardVideoAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.rvad=[[RewardVideoPage alloc] init];
    [self.rvad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 显示全屏视频广告
- (void) showFullScreenVideoAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.fsad=[[FullScreenVideoPage alloc] init];
    [self.fsad showAd:call eventSink:self.eventSink];
    result(@(YES));
}
// 加载信息流广告
- (void) loadFeedAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    self.fad=[[FeedAdLoad alloc] init];
    [self.fad loadFeedAdList:call result:result eventSink:self.eventSink];
}

// 清除信息流广告
- (void) clearFeedAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSArray *list= call.arguments[@"list"];
    for (NSNumber *ad in list) {
        [FeedAdManager.share removeAd:ad];
    }
    result(@(YES));
}

// 设置个性化推荐
// personalAdsType: String
// 不传或传空或传非01值没任何影响,默认不屏蔽
// 0，屏蔽个性化推荐广告；
// 1，不屏蔽个性化推荐广告
- (void) setUserExtData:(FlutterMethodCall*) call{
    NSString *personalAdsType = call.arguments[@"personalAdsType"];
    NSString *data = [NSString stringWithFormat:@"[{\"name\":\"personal_ads_type\",\"value\":\"%@\"}]", personalAdsType];
    [BUAdSDKManager setUserExtData: data];
}

#pragma mark - FlutterStreamHandler
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink=nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    self.eventSink=events;
    return nil;
}

// 添加事件
-(void) addEvent:(NSObject *) event{
    if(self.eventSink!=nil){
        self.eventSink(event);
    }
}

@end
