//
//  AdFeedView.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FlutterPangleAdsPlugin.h"

@interface AdFeedView : BaseAdPage<FlutterPlatformView>
@property (strong,nonatomic,nullable) FlutterPangleAdsPlugin *plugin;
@property int64_t viewId;
- (nonnull instancetype) initWithFrame:(CGRect)frame
                        viewIdentifier:(int64_t)viewId
                             arguments:(id _Nullable)args
                       binaryMessenger:(NSObject<FlutterBinaryMessenger>* _Nullable)messenger plugin:(FlutterPangleAdsPlugin* _Nullable) plugin;
- (nonnull UIView*) view;
@end
