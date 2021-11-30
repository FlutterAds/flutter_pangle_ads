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
// 广告位 id key
extern NSString * _Nonnull const kPosId;
// 广告位id
@property (weak,nonatomic,nullable) NSString *posId;
// 事件消息
@property (strong,nonatomic,nullable) FlutterEventSink eventSink;
// Window
@property (strong,nonatomic,nullable) UIWindow *mainWin;
// 根控制器
@property (strong,nonatomic,nullable) UIViewController *rootController;
// 屏幕宽度
@property CGFloat width;
// 屏幕高度
@property CGFloat height;
// 显示广告
- (void) showAd:(nonnull FlutterMethodCall *)call eventSink:(nonnull FlutterEventSink) events;
//// 加载广告
- (void) loadAd:(nonnull FlutterMethodCall *) call;
// 发送广告事件
-(void) sendEvent:(nonnull AdEvent *) event;
// 发送广告事件
-(void) sendEventAction:(nonnull NSString *) action;
// 发送广告错误事件
-(void) sendErrorEvent:(NSInteger) errCode withErrMsg:(nullable NSString*) errMsg;
@end
