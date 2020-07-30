//
//  DMNavigationController.m
//  DecorateMerchant
//
//  Created by anjuke on 2019/8/23.
//  Copyright © 2019 AnJuKe. All rights reserved.
//

#import "DMNavigationController.h"
#import "UIViewController+DMNavigationExtension.h"

#define kDefaultBackImageName @"icon_nav_arrow_l"

#pragma mark - DMNavigationController

@interface DMNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;
@property (nonatomic) BOOL shouldIgnorePushingViewControllers;

@end

@implementation DMNavigationController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.navigationBar.tintColor = [UIColor grayColor];
    self.delegate = self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.dm_navigationController = self;
        self.viewControllers = @[[DMWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.dm_navigationController = self;
        self.viewControllers = @[[DMWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    UIViewController *childVC = self.topViewController;
    if ([childVC isMemberOfClass:[DMWrapViewController class]] && [(DMWrapViewController *)childVC.childViewControllers.firstObject isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)((DMWrapViewController *)childVC.childViewControllers.firstObject)).topViewController;
    }else {
        return [super childViewControllerForStatusBarStyle];
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if ([viewController isMemberOfClass:[DMWrapViewController class]]) {
        viewController = ((DMWrapViewController *)viewController).rootViewController;
    }
    // dm_screenPopGestureDisabled为YES时，禁用手势返回
    if (viewController.dm_screenPopGestureDisabled) {
        self.interactivePopGestureRecognizer.enabled = NO;
        return;
    }
    if (viewController.dm_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)dm_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (DMWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

@end

#pragma mark - DMWrapViewController

static NSValue *dm_tabBarRectValue;

@implementation DMWrapViewController

+ (DMWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    DMWrapNavigationController *wrapNavController = [[DMWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    DMWrapViewController *wrapViewController = [[DMWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !dm_tabBarRectValue) {
        dm_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && dm_tabBarRectValue) {
        self.tabBarController.tabBar.frame = dm_tabBarRectValue.CGRectValue;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (BOOL)dm_fullScreenPopGestureEnabled {
    return [self rootViewController].dm_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    DMWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return [self.rootViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.rootViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.rootViewController preferredInterfaceOrientationForPresentation];
}

@end

#pragma mark - DMWrapNavigationController

@implementation DMWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated {
    if ([self.viewControllers.firstObject isMemberOfClass:[DMWrapViewController class]]) {
        DMNavigationController *dm_navigationController = ((DMWrapViewController *)self.viewControllers.firstObject).dm_navigationController;
        NSArray *vcArray = dm_navigationController.dm_viewControllers;
        for (UIViewController *vc  in [vcArray reverseObjectEnumerator]) {
            if ([vc isMemberOfClass:class]) {
                return [self popToViewController:vc animated:animated];
            }
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    DMNavigationController *dm_navigationController = viewController.dm_navigationController;
    NSInteger index = NSNotFound;
    index = [dm_navigationController.dm_viewControllers indexOfObject:viewController];
    
    if (index != NSNotFound && index >= 0 && index < dm_navigationController.dm_viewControllers.count) {
        return [self.navigationController popToViewController:dm_navigationController.viewControllers[index] animated:animated];
    }
    
    return nil;
}

- (DMWrapViewController *)processViewController:(UIViewController *)viewController {
    viewController.dm_navigationController = (DMNavigationController *)self.navigationController;
    viewController.dm_fullScreenPopGestureEnabled = viewController.dm_navigationController.fullScreenPopGestureEnabled;
    
    UIImage *backButtonImage = viewController.dm_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    //backbutton
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(-9, 0, 25, 25)];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    UIView *backButtonBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    backButtonBackgroundView.userInteractionEnabled = YES;
    [backButtonBackgroundView addSubview:backButton];
    if ([viewController respondsToSelector:@selector(didClickBackButton)]) {
        [backButton addTarget:viewController action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
        [backButtonBackgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:viewController action:@selector(didClickBackButton)]];
    }else {
        [backButton addTarget:self action:@selector(didTapBackButton) forControlEvents:UIControlEventTouchUpInside];
        [backButtonBackgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButtonBackgroundView)]];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonBackgroundView];
    
    return [DMWrapViewController wrapViewControllerWithViewController:viewController];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!viewController) {
#ifdef DEBUG
        @throw [[NSException alloc] initWithName:@"viewcontroller to be pushed is nil" reason:@"viewcontroller to be pushed is nil" userInfo:nil];
#endif
        return;
    }
    [self.navigationController pushViewController:[self processViewController:viewController] animated:animated];
}

- (void)didClickBackButtonBackgroundView {
    [self didTapBackButton];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.dm_navigationController = nil;
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

@end


