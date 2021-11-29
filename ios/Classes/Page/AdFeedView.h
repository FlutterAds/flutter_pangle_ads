//
//  AdFeedView.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import "FLutterPangleAdsPlugin.h"

@interface AdFeedView : BaseAdPage<FlutterPlatformView>
@property (strong,nonatomic) FlutterPangleAdsPlugin *plugin;
@property int64_t viewId;
- (instancetype) initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                     arguments:(id _Nullable)args
               binaryMessenger:(NSObject<FlutterBinaryMessenger>* _Nullable)messenger plugin:(FlutterPangleAdsPlugin* _Nullable) plugin;
- (UIView*) view;
@end
