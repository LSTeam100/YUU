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
#import "YUULoginCtrl.h"
#import "YUUAlertView.h"
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
    YUUResponse *res = [request getResponse];
    int statusCode=[request getResponse].code;
//    CGRect frame = CGRectMake(20,self.view.frame.size.height - 88 - 95,self.view.frame.size.width - 40, 95);
    if (token == true) {
        switch (statusCode) {
            case 1:
                [self naviTologin:statusCode];
//                [HUD showHUDTitle:@"token无效" durationTime:2];
                break;
            case 2:
                [self alertView:@"local_alert" IsForeverShow:false SuperCtrl:self];
            case 3:
                [self naviTologin:statusCode];
                break;
            default:
                [HUD showHUDTitle:res.msg durationTime:2];
                break;
        }
        
    }
    else{
        
        switch (statusCode) {
            case 1:
                [self naviTologin:statusCode];
                break;
            case 2:
                [self alertView:@"local_alert" IsForeverShow:false SuperCtrl:self];

            case 3:
                [self naviTologin:statusCode];
                break;
            default:
                [HUD showHUDTitle:res.msg durationTime:2];
                break;
        }
    }
    return NO;
}

-(void)alertView:(NSString *)imageName IsForeverShow:(BOOL)isForeverShow SuperCtrl:(UIViewController *)superCtrl {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"YUUAlertView" owner:nil options:nil];
    YUUAlertView *cView = [nibContents lastObject];
    cView.frame = self.view.frame;
    [cView showYUUAlert:imageName];
    DLOG(@"cView=%@",cView);
     [superCtrl.view addSubview:cView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (isForeverShow == false) {
            [cView removeFromSuperview];
        }
    });
}
//-(void)str:(NSString *)imageName test:(CGRect)frame{
//UIImage *img = [UIImage imageNamed:imageName];
//UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
//imageView.image = img;
//[HUD showCustomView:imageView];
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [HUD hide];
//});}
-(void)naviTologin:(int)statusCode{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([root.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)root.presentedViewController;
        UIViewController *c = navi.viewControllers[0];
        if ([c isKindOfClass:[YUULoginCtrl class]]) {
            DLOG(@"已经是登录页面无需弹出登录");
            switch (statusCode) {
                case 3:
                    [self alertView:@"closeMarket_alert" IsForeverShow:true SuperCtrl:c];
                    break;
                default:
                    break;
            }
            return ;
        }
    }
    
    
    [self presentViewController:navi animated:YES completion:^{
        switch (statusCode) {
            case 3:
                [self alertView:@"closeMarket_alert" IsForeverShow:true SuperCtrl:self.presentedViewController];
                break;
            default:
                break;
        }
        DLOG(@"展示登录页面");
    }];
}

- (void)dealloc {
    NSLog(@"dealloc %@",self);
}

@end
