//
//  DMTabBarController.h
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMTabBarController;

@protocol DMTabBarControllerProtocol <NSObject>

@required
- (void)didSelectedByTabBarController:(DMTabBarController *)tabbarController;

@end

@interface DMTabBarController : UITabBarController

@end

