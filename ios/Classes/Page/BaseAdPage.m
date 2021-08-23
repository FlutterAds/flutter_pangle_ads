//
//  BaseAdPage.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//

#import "BaseAdPage.h"

@implementation BaseAdPage

// 显示广告
-(void)showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink )events{
    self.posId=posId;
    self.eventSink=events;
    // 初始化开屏广告
    self.mainWin=[[UIApplication sharedApplication] keyWindow];
    // 获取宽高
    CGSize size=[[UIScreen mainScreen] bounds].size;
    self.width=size.width;
    self.height=size.height;
    [self loadAd:call];
}

// 发送广告事件
- (void)sendEvent:(AdEvent *)event{
    if(self.eventSink!=nil){
        self.eventSink([event toMap]);
    }
}
// 添加广告事件
- (void)sendEventAction:(NSString *)action{
    AdEvent *event=[[AdEvent alloc] initWithAdId:self.posId andAction:action];
    [self sendEvent:event];
}
// 添加广告错误事件
- (void)sendErrorEvent:(NSInteger)errCode withErrMsg:(NSString *)errMsg{
    AdErrorEvent *event=[[AdErrorEvent alloc] initWithAdId:self.posId errCode:[NSNumber numberWithInteger:errCode]  errMsg:errMsg];
    [self sendEvent:event];
}


@end
