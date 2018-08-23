//
//  ViewController.m
//  YUU
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "YUULoginCtrl.h"
#import "YUUMineDetailCtrl.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
//    YUULoginCtrl *login = [sb` instantiateViewControllerWithIdentifier:@"YUULoginCtrl"];
    
    YUUMineDetailCtrl *c = [sb instantiateViewControllerWithIdentifier:@"YUUMineDetailCtrl"];
    
    [self presentViewController:c animated:true completion:^{
        DLOG("展示登录页面");
    }];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
