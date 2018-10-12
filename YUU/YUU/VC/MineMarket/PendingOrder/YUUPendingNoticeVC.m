//
//  YUUPendingNoticeVC.m
//  YUU
//
//  Created by boli on 2018/10/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingNoticeVC.h"

@interface YUUPendingNoticeVC ()

@end

@implementation YUUPendingNoticeVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMineMarket" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"挂单交易须知";
    
    self.navigationController.navigationBar.topItem.title = @"";

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
