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
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    BOOL add = NO;
    for (UIView *v in self.navigationController.navigationBar.subviews) {
        if (v.tag == 10086) {
            add = YES;
        }
    }
    if (!add) {
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
        
        aview.tag = 10086;
        [self.navigationController.navigationBar addSubview:aview];
        
        // 取消导航栏下面的线
        self.navigationController.navigationBar.clipsToBounds = YES;
        
        [UINavigationBar.appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                                             NSForegroundColorAttributeName: YUUYellow
                                                             }];
        // 透明背景
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"120"] forBarMetrics:UIBarMetricsDefault];
        //    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"bg"]];
        
        // title color
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : YUUYellow};
    }
    
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
//    _isViewDidLoad = YES;
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


- (void)getHTTPData {}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)handleResponseError:(YUUBaseViewController *)currentController
                   request:(YUUBaseRequest *)request
                 needToken:(BOOL) token{
    int statusCode=[request getResponse].code;
    if (token == true) {
        switch (statusCode) {
            case 1:
                [self naviTologin];
                break;
            default:
                break;
        }
        
    }
    else{
        
    }
    
    
    //    if (treated) {
    //        [self showDefaultFailureMessage];
    //
    //    }
    //    if (statusCode == 0) {
    //        <#statements#>
    //    }
    //    if(statusCode==430||statusCode==431){
    //        [self handleSessionTimeout:currentController request:request];
    //        return YES;
    //    }
    //        else if(statusCode==-100){
    //        [self showMessage:[request getResponse].errorMessage];
    //        return YES;
    //    }
    //    else if (statusCode==502)
    //    {
    //        [self showMessage:@"没有权限"];
    //        return YES;
    //    }
    //    else if (statusCode==503)
    //    {
    //        [self showMessage:@"已存在该数据"];
    //    }
    //    else if(statusCode==504)
    //    {
    //        [self showMessage:@"数据库错误"];
    //    }
    //    else if (statusCode==505)
    //    {
    //        [self showMessage:@"密码错误"];
    //    }
    //    else if (statusCode==506)
    //    {
    //        [self showMessage:@"更新失败"];
    //    }
    //    else if (statusCode==516)
    //    {
    //        [self showMessage:@"库存不够"];
    //    }
    //    else if (statusCode==507)
    //    {
    //        [self showMessage:@"验证码错误"];
    //    }
    //    else if (statusCode==508)
    //    {
    //        [self showMessage:@"无权限"];
    //    }
    //    else if (statusCode==404)
    //    {
    //
    //    }
    //    else if (statusCode==450)
    //    {
    //        [self showMessage:@"该用户已存在"];
    //    }
    //    else if (statusCode==510)
    //    {
    //        [self showMessage:@"商铺歇业中"];
    //    }
    //    else if (statusCode==511)
    //    {
    //        [self showMessage:@"当前城市不支持"];
    //    }
    //    else{
    //        if(treated){
    //            [self showDefaultFailureMessage];
    //            return YES;
    //        }
    //    }
    return NO;
}

-(void)naviTologin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
    [self presentViewController:navi animated:YES completion:^{
        DLOG(@"展示登录页面");
    }];
}

@end
