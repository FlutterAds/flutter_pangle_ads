//
//  FullScreenVideoPage.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/24.
//

#import "BaseAdPage.h"
// 全屏视频广告
@interface FullScreenVideoPage : BaseAdPage<BUNativeExpressFullscreenVideoAdDelegate>
@property (nonatomic,strong) BUNativeExpressFullscreenVideoAd *fsad;
@end
