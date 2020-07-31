//
//  HomeViewController.m
//  OC-SwiftDemo
//
//  Created by Muyuli on 2019/8/27.
//  Copyright © 2019 Muyuli. All rights reserved.
//

#import "HomeViewController.h"
#import <Masonry/Masonry.h>

#import "Lottie-Swift.h"

@interface HomeViewController ()

@property (nonatomic, strong) CompatibleAnimationView *animationView;

@property (nonatomic, strong) CompatibleAnimation *animation;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.animation = [[CompatibleAnimation alloc] initWithName:@"8795-beach-cabin" bundle:[NSBundle mainBundle]];
    
    self.animationView = [[CompatibleAnimationView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    self.animationView.compatibleAnimation = self.animation;
    self.animationView.contentMode = UIViewContentModeScaleToFill;
   
    [self.view addSubview:self.animationView];
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(400, 400));
        make.center.equalTo(self.view);
    }];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.animationView playWithCompletion:^(BOOL finished) {
        
//        [WGToast showToastWithTitle:@"动画结束"];
        
    }];
}


@end
