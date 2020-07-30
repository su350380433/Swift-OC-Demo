//
//  DMTabBarController.m
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import "DMTabBarController.h"
#import "DMNavigationController.h"
#import "DMNavigationController.h"
#import "HomeViewController.h"
#import "DMNavigationController.h"
#import <objc/runtime.h>
#import "Swift-OC-Bridging-Header.h"
//#import "WGDesignerViewController.h"


@interface DMTabBarController () <UITabBarControllerDelegate>

@end

@implementation DMTabBarController

#pragma mark - 解决iOS12.1版本上Tabbar在VC pop的时候“跳动”问题（系统bug）
/**
 *  用 block 重写某个 class 的指定方法
 *  @param targetClass 要重写的 class
 *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
 *  @param implementationBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
 */
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    
                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        // 40是xs max上特有问题
                        if (!CGRectIsEmpty(selfObject.frame)&& (CGRectIsEmpty(firstArgv) || firstArgv.size.height < 40)) {
                            return;
                        }
                    }
                    
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    
    //tabbar init
    {

        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateNormal];
        // [UIColor colorWithRed:1 green:102/255. blue:0 alpha:1] 即 #FF6600
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1 green:102/255. blue:0 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateSelected];

        HomeViewController *homeVC = [[HomeViewController alloc]init];
        homeVC.hidesBottomBarWhenPushed = NO;
        DMNavigationController *homeNC = [[DMNavigationController alloc] initWithRootViewController:homeVC];
        homeNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home_normal"] tag:0];
        [homeNC.tabBarItem setImage:[[UIImage imageNamed:@"tab_theme_nrl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [homeNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_theme_hlt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [homeNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];

        
        WGDesignerViewController *designerVC = [[WGDesignerViewController alloc] init];
        designerVC.hidesBottomBarWhenPushed = NO;
        DMNavigationController *designerNC = [[DMNavigationController alloc ] initWithRootViewController:designerVC];
        designerNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设计" image:[UIImage imageNamed:@"tabbar_discover_normal"] tag:1];
        [designerNC.tabBarItem setImage:[[UIImage imageNamed:@"tab_designer_nrl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [designerNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_designer_hlt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [designerNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];

        
        WGMineViewController *mineVC = [[WGMineViewController alloc] init];
        mineVC.hidesBottomBarWhenPushed = NO;
        DMNavigationController *mineNC = [[DMNavigationController alloc ] initWithRootViewController:mineVC];
        mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_discover_normal"] tag:1];
        [mineNC.tabBarItem setImage:[[UIImage imageNamed:@"tab_profile_nrl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [mineNC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_profile_hlt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [mineNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        
        
        self.viewControllers = @[homeNC,
                                 designerNC,
                                 mineNC
                                 ];
    }
}

#pragma mark -  UITabBarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[DMNavigationController class]] && [[((DMNavigationController *)viewController).dm_viewControllers firstObject] conformsToProtocol:@protocol(DMTabBarControllerProtocol)] && [[((DMNavigationController *)viewController).dm_viewControllers firstObject] respondsToSelector:@selector(didSelectedByTabBarController:)]) {
        id<DMTabBarControllerProtocol> controller = [((DMNavigationController *)viewController).dm_viewControllers firstObject];
        [controller didSelectedByTabBarController:self];
    }
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
