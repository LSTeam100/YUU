//
//  YUUBaseViewController.m
//  YUU
//
//  Created by boli on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseViewController.h"
#import "UIColor+Help.h"
#import "UINavigationController+help.h"
#import "YUUColor.h"

@interface YUUBaseViewController ()

@end

@implementation YUUBaseViewController

+ (instancetype)storyboardInstanceType {
    NSAssert(YES, @"请重新");
    return [[self alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *aview = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    aview.userInteractionEnabled = NO;
    
    UIView *middle = [[UIView alloc] initWithFrame:CGRectMake(0, 2, aview.frame.size.width, aview.frame.size.height - 4)];
    middle.backgroundColor = YUUYellow;
    middle.alpha = 0.05;
    [aview addSubview:middle];
    
    UIView *up = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aview.frame.size.width, 2)];
    up.backgroundColor = YUUYellow;
    [aview addSubview:up];
    
    UIView *down = [[UIView alloc] initWithFrame:CGRectMake(0, aview.frame.size.height-2, aview.frame.size.width, 2)];
    down.backgroundColor = YUUYellow;
    [aview addSubview:down];
    
    [self.navigationController.navigationBar addSubview:aview];
    
    // 取消导航栏下面的线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    [UINavigationBar.appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                                         NSForegroundColorAttributeName: YUUYellow
                                                         }];
    // 透明背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"120"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"bg"]];

    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCustomBackItem {
    [self.navigationController.navigationBar setBackIndicatorImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
