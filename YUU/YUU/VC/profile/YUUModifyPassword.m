//
//  YUUModifyPassword.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUModifyPassword.h"
#import "YUUForgetCtrl.h"
#import "HUD.h"
#import "YUUModifyTransactionRequest.h"
#import "YUUModifyLoginRequest.h"
#import "YUUUserData.h"
@interface YUUModifyPassword ()
@property(nonatomic,weak)IBOutlet UITextField *oldField;
@property(nonatomic,weak)IBOutlet UITextField *makeSureField;
@property(nonatomic,weak)IBOutlet UIButton *forgetTransactionBtn;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;

@end

@implementation YUUModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oldField.secureTextEntry = true;
    self.passwordField.secureTextEntry = true;
    self.makeSureField.secureTextEntry = true;
    
    if (self.modifyType == loginType) {
        self.title = @"修改登录密码";
        self.forgetTransactionBtn.hidden = YES;
    }
    else{
        self. title = @"修改交易密码";
    }
    // Do any additional setup after loading the view.
}

-(IBAction)naviToForgetpassword:(id)sender{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUForgetCtrl *forget = [sb instantiateViewControllerWithIdentifier:@"YUUForgetCtrl"];
    forget.forgetType = forgetTransactionType;
    [self.navigationController pushViewController:forget animated:YES];
}
-(IBAction)submitAction:(id)sender{
    
    if (self.oldField.text.length == 0) {
        [HUD showHUDTitle:@"旧密码不能为空" durationTime:2];
        return;
    }
    
    if (self.passwordField.text.length == 0) {
        [HUD showHUDTitle:@"新密码不能为空" durationTime:2];
        return;
    }
    
    if (self.makeSureField.text.length == 0) {
        [HUD showHUDTitle:@"重复密码不能为空" durationTime:2];
        return;
    }
    
    if ([self.passwordField.text isEqualToString: self.makeSureField.text] == false) {
        [HUD showHUDTitle:@"两次密码输入不一致" durationTime:2];
        return;
    }
    
    
    if (self.modifyType == loginType) {
        WeakSelf
        [self setBusyIndicatorVisible:YES];
        NSString *token = [YUUUserData shareInstance].userModel.token;
        YUUModifyLoginRequest *modifyLogin = [[YUUModifyLoginRequest alloc]initWithModifyLogin:token Oldpsw:self.oldField.text Newpsw:self.passwordField.text SuccessCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [HUD showHUDTitle:@"修改密码成功" durationTime:2];
            if (self.modifyType == loginType) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self logout];
                });
            }

            
        } failureCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            YUUResponse *res = [request getResponse];
            switch (res.code) {
                case 0:
                    DLOG(@"信息错误");
                    [HUD showHUDTitle:res.msg durationTime:2];
                    break;
                case 1:
                    DLOG(@"token无效");
                    break;
                case 3:
                    DLOG(@"闭市");
                    showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);

                    break;
                default:
                    break;
            }
            [self handleResponseError:self request:request needToken:YES];
            [HUD showHUDTitle:res.msg durationTime:2];
        }];
        [modifyLogin start];
    }
    else{
        WeakSelf
        NSString *token = [YUUUserData shareInstance].userModel.token;
        [self setBusyIndicatorVisible:YES];
        YUUModifyTransactionRequest *modifyTransaction = [[YUUModifyTransactionRequest alloc]initWithModifyTransaction:token Oldtraderpsw:self.oldField.text Newtraderpsw:self.passwordField.text SuccessCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [HUD showHUDTitle:@"修改密码成功" durationTime:2];

        } failureCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            YUUResponse *res = [request getResponse];
            switch (res.code) {
                case 0:
                    DLOG(@"信息错误");
                    [HUD showHUDTitle:res.msg durationTime:2];

                    break;
                case 1:
                    DLOG(@"token无效");
                    break;
                case 3:
                    DLOG(@"闭市");
                    showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);

                    break;
                default:
                    [HUD showHUDTitle:res.msg durationTime:2];

                    break;
            }
            [self handleResponseError:self request:request needToken:YES];

        }];
        
        [modifyTransaction start];
        
    }
}
-(void)logout{
    [[YUUUserData shareInstance]removeUserData];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
    [self presentViewController:navi animated:YES completion:^{
        DLOG(@"展示登录页面");
    }];

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
