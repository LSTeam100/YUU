//
//  YUUSignUpCtrl.m
//  YUU
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSignUpCtrl.h"
#import "Header.h"
#import "YUURegisterRequest.h"
#import "HUD.h"
#import "YUUCommonModel.h"
#import "YUUSendMessageRequest.h"
#import "YUUUserData.h"
#import "YUULoginRequest.h"

@interface YUUSignUpCtrl ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat originInputTopMargin;
    NSTimer *countDownTimer;
    int countNum;


}
@property(nonatomic,weak)IBOutlet UITextField *phoneField;
@property(nonatomic,weak)IBOutlet UITextField *messageField;
@property(nonatomic,weak)IBOutlet UITextField *imgField;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;
@property(nonatomic,weak)IBOutlet UITextField *recommedField;
@property(nonatomic,weak)IBOutlet UIButton *signBtn;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;
@property(nonatomic,weak)IBOutlet UILabel *countDownLabel;
@property(nonatomic,weak)IBOutlet UIButton *sendMsgBtn;
@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@property(nonatomic,weak)IBOutlet UILabel *localVerCodeLabel;

@end

@implementation YUUSignUpCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
    }];
    self.passwordField.secureTextEntry = true;
    self.recommedField.keyboardType = UIKeyboardTypeNumberPad;
    if (countDownTimer) {
        self.countDownLabel.hidden = NO;
        self.sendMsgBtn.hidden = YES;
        
    }
    else{
        self.countDownLabel.hidden = YES;
        self.sendMsgBtn.hidden = NO;
        countNum = 300;
    }
    
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.messageField.keyboardType = UIKeyboardTypeNumberPad;
    self.imgField.keyboardType = UIKeyboardTypeNumberPad;
    NSString *code = getLocalVerifyCodeWithBit(4);
    self.localVerCodeLabel.text = code;
    
    
//    self.phoneField.text = @"15630008679";
//    self.recommedField.text = @"1";
//    self.imgField.text = code;
//    self.passwordField.text = @"r20855090";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeView = textField;
    if (textField != self.phoneField) {
        self.activeView = _signBtn;
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    originInputTopMargin = self.cstTopMargin.constant;
    [self registerKeyboardNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotification];
}
-(IBAction)registerAction:(id)sender{
    
    if (self.phoneField.text.length == 0) {
        [HUD showHUDTitle:@"手机号码不能为空" durationTime:2];
        return;
    }
    
    if (self.messageField.text.length == 0) {
        [HUD showHUDTitle:@"验证码不能为空" durationTime:2];
        return;
    }
    
    if (self.imgField.text == 0) {
        [HUD showHUDTitle:@"图片验证码不能为空" durationTime:2];
        return;
    }
    
    if (self.passwordField.text == 0) {
        [HUD showHUDTitle:@"密码不能为空" durationTime:2];
        return;
    }
    if (self.recommedField.text == 0) {
        [HUD showHUDTitle:@"推荐人手机号不能为空" durationTime:2];
        return;
    }
    if (isMobileValid(self.phoneField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    if (isUserPwdValid(_passwordField.text) == false) {
        [HUD showHUDTitle:@"密码要是字母+数字的组合且大于8位" durationTime:2];
        return;
    }
    
//    if (isUserPwdValid(_recommedField.text) == false) {
//        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
//        return;
//    }
    
    if (![self.imgField.text isEqualToString:self.localVerCodeLabel.text]) {
        [HUD showHUDTitle:@"输入验证码有误" durationTime:2];
        return;
    }
    
    
    [self setBusyIndicatorVisible:YES];
    WeakSelf
    YUURegisterRequest *req = [[YUURegisterRequest alloc]initWithMobilePhone:_phoneField.text IDCode:[NSNumber numberWithInt:[_messageField.text intValue]] Password:_passwordField.text UpMemberip:_recommedField.text SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUCommonModel *model = [request getResponse].data;
        [[YUUUserData shareInstance] saveUserData:model];
        [HUD showHUDTitle:@"注册成功" durationTime:2];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf login:weakSelf.phoneField.text Pwd:weakSelf.passwordField.text];            
        });
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"提示用户错误信息");
                break;
            case 1:
                DLOG(@"锁定发送短信按钮");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
    }];
    [req start];
    
}
-(void)dealloc{
    [countDownTimer invalidate];
    countDownTimer = nil;
    
}
-(IBAction)sendVerifyCode:(id)sender{
    if (self.phoneField.text.length == 0) {
        [HUD showHUDTitle:@"手机号不能为空" durationTime:2];
        return;
    }
    
    if (isMobileValid(self.phoneField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    [self setBusyIndicatorVisible:YES];
    YUUSendMessageRequest *sendMsg = [[YUUSendMessageRequest alloc]initWithSendMessage:self.phoneField.text SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        if (countDownTimer == nil) {
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
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
    }
    else{
        self.countDownLabel.text = [NSString stringWithFormat:@"%d",countNum];
    }
}

-(IBAction)login:(NSString *)account Pwd:(NSString *)pwd{
    
    [self setBusyIndicatorVisible:YES];
    YUULoginRequest *req = [[YUULoginRequest alloc]initWithMobilePhone:account Password:pwd SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUCommonModel *login = [request getResponse].data;
        [[YUUUserData shareInstance] saveUserData:login];
        [self dismissViewControllerAnimated:YES completion:^{
            DLOG(@"关闭登录页面");
        }];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"用户锁定");
                break;
            case 1:
                DLOG(@"需要提示用户错误信息");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
    }];
    [req start];
    
    
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
