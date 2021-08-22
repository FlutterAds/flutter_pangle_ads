//
//  AdEvent.h
//  flutter_qq_ads
//
//  Created by zero on 2021/8/13.
//

#import <Foundation/Foundation.h>
// 广告事件
@interface AdEvent : NSObject
// 广告 id
@property (copy, nonatomic) NSString *adId;
// 操作
@property (copy, nonatomic) NSString *action;
// 构造广告事件
- (id) initWithAdId:(NSString *) adId andAction:(NSString *)action;
// 转换为 Map 操作
- (NSDictionary*) toMap;
@end
