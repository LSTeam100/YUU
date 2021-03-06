//
//  YUUTabBarController.m
//  YUU
//
//  Created by boli on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUTabBarController.h"
#import "UIColor+Help.h"
#import "YUULoginCtrl.h"
#import "YUUUserData.h"


@interface YUUTabBarController () <UITabBarControllerDelegate>

@end

@implementation YUUTabBarController

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUTabBar" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 2)];
    aview.backgroundColor = [UIColor hex:@"#e4c177"];
    [self.tabBar addSubview:aview];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"48"]];
//    [self.tabBar setShadowImage:[UIImage imageNamed:@"bg"]];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"48"];
    [self.tabBar insertSubview:bgImageView atIndex:0];
    self.tabBar.clipsToBounds = YES;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"#E3C278"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"#EF6607"]} forState:UIControlStateSelected];
    
    NSArray *titles = @[@"机市", @"矿机", @"矿池", @"矿市", @"我的"];

    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_unSelected",i]];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_selected",i]];
        vc.tabBarItem.title = titles[i];
    }
    NSLog(@"%f,%f",self.tabBar.frame.size.width,self.tabBar.frame.size.height);

    self.delegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkLoginStatus];
}
-(void)checkLoginStatus{
    [[YUUUserData shareInstance] getUserData];
    if ([YUUUserData shareInstance].userModel == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
        [self presentViewController:navi animated:YES completion:^{
            DLOG(@"展示登录页面");
        }];
    }
}
-(void)setupCommonConfigure{
    [UIDevice getUserAgent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        if (nav.viewControllers.count == 1) {
            UIViewController *vc = nav.topViewController;
            if ([vc isKindOfClass:[YUUBaseViewController class]]) {
                if ([(YUUBaseViewController *)vc isViewLoaded]) {                
                    [(YUUBaseViewController *)vc getHTTPData];
                }
            }
        }
    }
}

@end
