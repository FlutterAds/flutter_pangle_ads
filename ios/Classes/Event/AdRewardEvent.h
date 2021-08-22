//
//  AdRewardEvent.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/19.
//

#import "BaseAdPage.h"
// 广告激励事件
@interface AdRewardEvent : AdEvent
// 服务端验证唯一id
@property (copy,nonatomic) NSString *transId;
// 服务端验证的自定义信息
@property (copy,nonatomic) NSString *customData;
// 服务端验证的用户信息
@property (copy,nonatomic) NSString *userId;
// 构造广告激励事件
-(id) initWithAdId:(NSString*) adId transId:(NSString*) transId customData:(NSString*) customData userId:(NSString*) userId;

@end
