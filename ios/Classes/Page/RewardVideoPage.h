//
//  RewardVideoPage.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/19.
//

#import "BaseAdPage.h"
#import "GDTRewardVideoAd.h"
// 激励视频页面
@interface RewardVideoPage : BaseAdPage<GDTRewardedVideoAdDelegate>
@property (nonatomic, strong) GDTRewardVideoAd *rvad;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
@end
