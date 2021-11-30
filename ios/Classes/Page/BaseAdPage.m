//
//  BaseAdPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"

@implementation BaseAdPage
// 广告位id
NSString *const kPosId=@"posId";
// 显示广告
-(void)showAd:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink )events{
    
    self.posId=call.arguments[kPosId];
    self.eventSink=events;
    // 获取主 window
    self.mainWin=[[UIApplication sharedApplication] keyWindow];
    self.rootController=self.mainWin.rootViewController;
    // 获取宽高
    CGSize size=[[UIScreen mainScreen] bounds].size;
    self.width=size.width;
    self.height=size.height;
    [self loadAd:call];
}

- (void)loadAd:(nonnull FlutterMethodCall *)call {
    NSLog(@"%s",__FUNCTION__);
}


// 发送广告事件
- (void)sendEvent:(AdEvent *)event{
    if(self.eventSink!=nil){
        self.eventSink([event toMap]);
    }
}
// 发送广告事件
- (void)sendEventAction:(NSString *)action{
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:action];
    [self sendEvent:event];
}
// 发送广告错误事件
- (void)sendErrorEvent:(NSInteger)errCode withErrMsg:(NSString *)errMsg{
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:errCode]  errMsg:errMsg];
    [self sendEvent:event];
}


@end
