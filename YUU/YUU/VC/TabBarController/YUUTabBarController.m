//
//  YUUTabBarController.m
//  YUU
//
//  Created by boli on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUTabBarController.h"
#import "UIColor+Help.h"

@interface YUUTabBarController ()

@end

@implementation YUUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 2)];
    aview.backgroundColor = [UIColor hex:@"#e4c177"];
    [self.tabBar addSubview:aview];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"bg"]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"bg"]];
    self.tabBar.clipsToBounds = YES;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"#E3C278"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor hex:@"#EF6607"]} forState:UIControlStateSelected];

    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_unSelected",i]];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_selected",i]];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
