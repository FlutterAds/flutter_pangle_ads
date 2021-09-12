//
//  SplashViewController.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/9/12.
//

#import <UIKit/UIKit.h>
#import "BaseAdPage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : UIViewController<BUSplashAdDelegate>
@property (strong, nonatomic) BUSplashAdView *splashAd;
@property (strong, nonatomic) UIView *splashView;
@property (nonatomic,copy) NSString *posId;
@property (nonatomic,copy) NSString *logo;
@property double timeout;
@end

NS_ASSUME_NONNULL_END
