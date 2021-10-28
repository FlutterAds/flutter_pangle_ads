//
//  SplashViewController.h
//  flutter_pangle_ads
//
//  Created by zero on 2021/9/12.
//

#import <UIKit/UIKit.h>
#import "BaseAdPage.h"
#import "SplashPage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : UIViewController<BUSplashAdDelegate>
@property (strong, nonatomic) SplashPage *sp;
@property (strong, nonatomic) BUSplashAdView *splashAd;
@property (strong, nonatomic) UIView *splashView;
@property (nonatomic,copy) NSString *posId;
@property (nonatomic,copy) NSString *logo;
@property double timeout;
@property int buttonType;
@end

NS_ASSUME_NONNULL_END
