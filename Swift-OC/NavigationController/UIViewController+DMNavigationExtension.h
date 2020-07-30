//
//  UIViewController+DMNavigationExtension.h
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMNavigationController.h"

@interface UIViewController (DMNavigationExtension)

@property (nonatomic, assign) BOOL dm_screenPopGestureDisabled;

@property (nonatomic, assign) BOOL dm_fullScreenPopGestureEnabled;

@property (nonatomic, weak) DMNavigationController *dm_navigationController;

@end

