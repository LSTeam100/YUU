//
//  YUUForgetCtrl.m
//  YUU
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUForgetCtrl.h"
#import "YUUForgetRequest.h"
#import "YUUCommonModel.h"
#import "HUD.h"
#import "YUUSendMessageRequest.h"
#import "YUUForgetTransactionRequest.h"
@interface YUUForgetCtrl ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat originInputTopMargin;
    NSTimer *countDownTimer;
    int countNum;
}
@property(nonatomic,weak)IBOutlet UITextField *phoneTextField;
@property(nonatomic,weak)IBOutlet UITextField *codeTextField;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;
@property(nonatomic,weak)IBOutlet UITextField *resetPasswordField;
@property(nonatomic,weak)IBOutlet UIButton *submitBtn;
@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;
@property(nonatomic,weak)IBOutlet UILabel *countDownLabel;
@property(nonatomic,weak)IBOutlet UIButton *sendMsgBtn;


@end

@implementation YUUForgetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.forgetType == forgetLoginType) {
        self.title = @"忘记密码";
    }
    else{
        self.title = @"忘记交易密码";
    }
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
    }];
    if (countDownTimer) {
        self.countDownLabel.hidden = NO;
        self.sendMsgBtn.hidden = YES;
        
    }
    else{
        self.countDownLabel.hidden = YES;
        self.sendMsgBtn.hidden = NO;
        countNum = 300;
    }
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    UIColor *color = [UIColor whiteColor];
    
    
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_codeTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
     _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_passwordField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    _resetPasswordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_resetPasswordField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    
    self.passwordField.secureTextEntry = YES;
    self.resetPasswordField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeView = textField;
    if (textField == self.resetPasswordField) {
        self.activeView = _submitBtn;
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //    if (textField == account) {
    //
    //    }
    [self tapCancelGesture:true];
    
}
-(void)tapCancelGesture:(bool)ret{
    if (ret) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self.view addGestureRecognizer:tap];
        self.tapCancelGesture = tap;
    }
    else{
        if (self.tapCancelGesture) {
            UITapGestureRecognizer *g = self.tapCancelGesture;
            [self.view removeGestureRecognizer:g];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self tapCancelGesture:false];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return  true;
}
- (void)moveUp:(float)shift{
    self.cstTopMargin.constant -= shift;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)reover{
    [UIView animateWithDuration:0.2 animations:^{
        self.cstTopMargin.constant = self->originInputTopMargin;
        [self.view layoutIfNeeded];
    }];
}

-(IBAction)forgetAction:(id)sender{
    
    if (self.phoneTextField.text == 0) {
        [HUD showHUDTitle:@"手机号码不能为空" durationTime:2];
        return;
    }
    
    if (self.codeTextField.text == 0) {
        [HUD showHUDTitle:@"验证码不能为空" durationTime:2];
        return;
    }
    
    if (self.passwordField.text == 0) {
        [HUD showHUDTitle:@"密码不能为空" durationTime:2];
        return;
    }
    
    if (self.resetPasswordField.text == 0) {
        [HUD showHUDTitle:@"重复密码不能为空" durationTime:2];
        return;
    }
    
    
    
    if (isMobileValid(self.phoneTextField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    if (isUserPwdValid(self.passwordField.text) == false) {
        [HUD showHUDTitle:@"密码要是字母+数字的组合且大于8位" durationTime:2];
        return;
    }
    
    if (self.passwordField.text != self.resetPasswordField.text) {
        [HUD showHUDTitle:@"密码输入不一致" durationTime:2];
        return;
    }
    
    [self setBusyIndicatorVisible:YES];
    if (self.forgetType == forgetLoginType) {
        YUUForgetRequest *forget = [[YUUForgetRequest alloc]initWithMobilePhone:self.phoneTextField.text Password:self.passwordField.text IDCode:[NSNumber numberWithInt:[self.codeTextField.text intValue]] SuccessCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [HUD showHUDTitle:@"登录密码重置成功" durationTime:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failureCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            YUUResponse *res = [request getResponse];
            switch (res.code) {
                case 0:
                    [HUD showHUDTitle:res.msg durationTime:2];
                    break;
                case 1:
                    [HUD showHUDTitle:@"token无效" durationTime:2];
                    break;
                case 2:
                    [HUD showHUDTitle:@"锁定发送短信按钮" durationTime:2];
                    break;
                default:
                    break;
            }
            [self handleResponseError:self request:request needToken:YES];
        }];
        
        [forget start];
    }
    else{
        
        YUUForgetTransactionRequest *req = [[YUUForgetTransactionRequest alloc]initWithForgetTransaction:[YUUUserData shareInstance].token Memberphone:self.phoneTextField.text Newtraderpsw:self.passwordField.text VerfiCode:self.codeTextField.text SuccessCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [HUD showHUDTitle:@"交易密码重置成功" durationTime:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

        } failureCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            YUUResponse *res = [request getResponse];
            switch (res.code) {
                case 0:
                    [HUD showHUDTitle:res.msg durationTime:2];
                    break;
                case 1:
                    [HUD showHUDTitle:@"token无效" durationTime:2];
                    break;
                case 2:
                    [HUD showHUDTitle:@"锁定发送短信按钮" durationTime:2];
                    break;
                default:
                    break;
            }
            [self handleResponseError:self request:request needToken:YES];

        }];
        [req start];
        
    }
    
    
    
    
}

-(IBAction)sendVerifyCode:(id)sender{
    if (self.phoneTextField.text.length == 0) {
        [HUD showHUDTitle:@"手机号不能为空" durationTime:2];
        return;
    }
    
    if (isMobileValid(self.phoneTextField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    [self setBusyIndicatorVisible:YES];
    YUUSendMessageRequest *sendMsg = [[YUUSendMessageRequest alloc]initWithSendMessage:self.phoneTextField.text SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        if (countDownTimer == nil) {
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        if (countDownTimer == nil) {
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"错误信息");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
        
    }];
    [sendMsg start];

}
-(void)timerAction{
    self.countDownLabel.hidden = NO;
    self.sendMsgBtn.hidden = YES;
    countNum --;
    if (countNum == 0) {
        [countDownTimer invalidate];
        countDownTimer = nil;
        self.sendMsgBtn.hidden = NO;
        self.countDownLabel.hidden = YES;
        countNum = 300;
    }
    else{
        self.countDownLabel.text = [NSString stringWithFormat:@"%d",countNum];
    }
}
-(void)dealloc{
    [countDownTimer invalidate];
    countDownTimer = nil;
  
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    originInputTopMargin = self.cstTopMargin.constant;
    [self registerKeyboardNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotification];
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
