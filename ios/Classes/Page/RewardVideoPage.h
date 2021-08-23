//
//  RewardVideoPage.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/8/19.
//

#import "BaseAdPage.h"
// 激励视频页面
@interface RewardVideoPage : BaseAdPage<BUNativeExpressRewardedVideoAdDelegate>
@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rvad;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
@end
