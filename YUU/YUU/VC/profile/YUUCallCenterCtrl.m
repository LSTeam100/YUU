//
//  YUUCallCenterCtrl.m
//  YUU
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCallCenterCtrl.h"
#import "YUUCallCenterRequest.h"
#import "HUD.h"
@interface YUUCallCenterCtrl ()
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;

@end

@implementation YUUCallCenterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服中心";
    [self callCenterRequest];
    // Do any additional setup after loading the view.
}
-(void)callCenterRequest{
    [self setBusyIndicatorVisible:YES];
    YUUCallCenterRequest *callCenter = [[YUUCallCenterRequest alloc]initWithCallCenter:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        NSDictionary* data= [request getResponse].data;
        self.titleLabel.text = data[@"servicetext"];


    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"错误信息");
                break;
            case 1:
                DLOG(@"token无效");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
        [self handleResponseError:self request:request needToken:YES];

    }];
    [callCenter start];
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
