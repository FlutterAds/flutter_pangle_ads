//
//  BaseAdPage.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/18.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "AdEvent.h"
#import "AdErrorEvent.h"
#import "AdRewardEvent.h"
#import "AdEventAction.h"
#import <BUAdSDK/BUAdSDK.h>
// 基础广告页面
@interface BaseAdPage : NSObject
// 广告位id
@property (weak,nonatomic) NSString *posId;
// 事件消息
@property (strong,nonatomic) FlutterEventSink eventSink;
// Window
@property (strong,nonatomic) UIWindow *mainWin;
// 屏幕宽度
@property CGFloat width;
// 屏幕高度
@property CGFloat height;
// 显示广告
- (void) showAd:(NSString *)posId methodCall:(FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink) events;
// 加载广告
- (void) loadAd:(FlutterMethodCall *) call;
// 添加广告事件
-(void) sendEvent:(AdEvent *) event;
// 添加广告事件
-(void) sendEventAction:(NSString *) action;
// 添加广告错误事件
-(void) sendErrorEvent:(NSInteger) errCode withErrMsg:(NSString*) errMsg;
@end
