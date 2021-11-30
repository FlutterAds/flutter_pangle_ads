//
//  AdBannerView.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/31.
//

#import "BaseAdPage.h"
#import "FlutterPangleAdsPlugin.h"
@interface AdBannerView : BaseAdPage<FlutterPlatformView>
@property (strong,nonatomic,nullable) FlutterPangleAdsPlugin *plugin;
- (nonnull instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>* _Nullable)messenger plugin:(FlutterPangleAdsPlugin* _Nullable) plugin;

- (nonnull UIView*)view;
@end
