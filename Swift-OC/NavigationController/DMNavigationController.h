//
//  DMNavigationController.h
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (DMWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface DMWrapNavigationController : UINavigationController

//替换前调用包装
- (DMWrapViewController *)processViewController:(UIViewController *)viewController;

@end

@interface DMNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *dm_viewControllers;

@end

