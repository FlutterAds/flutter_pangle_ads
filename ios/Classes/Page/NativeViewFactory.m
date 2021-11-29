//
//  NativeViewFactory.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/31.
//

#import "NativeViewFactory.h"
// 原生平台 View 工厂
@implementation NativeViewFactory

- (instancetype)initWithViewName:(NSString *)viewName withMessenger:(NSObject<FlutterBinaryMessenger> *)messenger withPlugin:(FlutterPangleAdsPlugin *)plugin{
    self = [super init];
    if (self) {
        self.viewName = viewName;
        self.messenger = messenger;
        self.plugin = plugin;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    if (self.viewName==kAdBannerViewId) {
        return [[AdBannerView alloc] initWithFrame:frame
                                    viewIdentifier:viewId
                                         arguments:args
                                   binaryMessenger:self.messenger
                                            plugin:self.plugin];
    }else{
        return [[AdFeedView alloc] initWithFrame:frame
                                    viewIdentifier:viewId
                                         arguments:args
                                   binaryMessenger:self.messenger
                                            plugin:self.plugin];
    }
    
}
@end
