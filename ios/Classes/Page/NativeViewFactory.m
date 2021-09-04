//
//  NativeViewFactory.m
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/31.
//

#import "NativeViewFactory.h"
// 原生平台 View 工厂
@implementation NativeViewFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterPangleAdsPlugin *)plugin{
    self = [super init];
    if (self) {
        self.messenger = messenger;
        self.plugin=plugin;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    return [[AdBannerView alloc] initWithFrame:frame
                                viewIdentifier:viewId
                                     arguments:args
                               binaryMessenger:self.messenger
                                        plugin:self.plugin];
}
@end
