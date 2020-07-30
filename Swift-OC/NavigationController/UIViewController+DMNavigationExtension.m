//
//  UIViewController+DMNavigationExtension.m
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import "UIViewController+DMNavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (DMNavigationExtension)

- (BOOL)dm_screenPopGestureDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDm_screenPopGestureDisabled:(BOOL)screenPopGestureDisabled {
    objc_setAssociatedObject(self, @selector(dm_screenPopGestureDisabled), @(screenPopGestureDisabled), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dm_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDm_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(dm_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
}

- (DMNavigationController *)dm_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDm_navigationController:(DMNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(dm_navigationController), navigationController, OBJC_ASSOCIATION_RETAIN);
}

@end
