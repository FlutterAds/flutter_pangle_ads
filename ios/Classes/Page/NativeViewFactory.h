//
//  NativeViewFactory.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/31.
//
#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "AdBannerView.h"
#import "AdFeedView.h"

// 原生平台 View 工厂
@interface NativeViewFactory : NSObject<FlutterPlatformViewFactory>
@property (strong,nonatomic) NSObject<FlutterBinaryMessenger> *messenger;
@property (strong,nonatomic) FlutterPangleAdsPlugin *plugin;
@property (strong,nonatomic) NSString *viewName;
- (instancetype)initWithViewName:(NSString*) viewName withMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterPangleAdsPlugin*) plugin;
@end
