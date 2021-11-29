//
//  AdFeedView.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import "AdFeedView.h"

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
    return self;
}

- (UIView *)view{
    return self.feedView;
}

- (void)loadAd:(FlutterMethodCall *)call{
//    int width = [call.arguments[@"width"] intValue];
//    int height = [call.arguments[@"height"] intValue];
//    int count = [call.arguments[@"count"] intValue];
    
    int width =375;
    int height = 128;
    int count = 3;
    
    BUAdSlot *slot= [[BUAdSlot alloc]init];
    slot.ID=self.posId;
    slot.AdType=BUAdSlotAdTypeFeed;
    BUSize *size=[BUSize sizeBy:BUProposalSize_Feed228_150];
    slot.imgSize=size;
    slot.position=BUAdSlotPositionFeed;
    if(!self.adManager){
        self.adManager= [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake(width, height)];
    }
    self.adManager.adSize=CGSizeMake(width, height);
    self.adManager.delegate=self;
    // 加载广告
    [self.adManager loadAdDataWithCount:count];
}

#pragma mark BUNativeExpressAdViewDelegate

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error.code withErrMsg:error.localizedDescription];
}

- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views{
    NSLog(@"%s",__FUNCTION__);
    if (views.count) {
//        [views enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        }];
        BUNativeExpressAdView *adView=views.firstObject;
        adView.rootViewController=self.rootController;
//        [self.feedView removeFromSuperview];
        [self.feedView addSubview:adView];
        [adView render];
    }
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"%s",__FUNCTION__);
}

@end
