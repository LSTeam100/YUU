//
//  YUUProfileAuthenEditeCtrl.m
//  YUU
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUProfileAuthenEditeCtrl.h"
#import "HUD.h"
#import "YUUCommonModel.h"
#import "YUUCertificationRequest.h"
#import "YUUUserData.h"
#import "YUUSendMessageRequest.h"
//static NSTimer *countDownTimer;

@interface YUUProfileAuthenEditeCtrl ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat originInputTopMargin;
    NSTimer *countDownTimer;
    int countNum;
}
@property(nonatomic,weak)IBOutlet UITextField *nameField;
@property(nonatomic,weak)IBOutlet UITextField *idCardField;
@property(nonatomic,weak)IBOutlet UITextField *bankField;
@property(nonatomic,weak)IBOutlet UITextField *prePhoneField;
@property(nonatomic,weak)IBOutlet UITextField *messageCode;
@property(nonatomic,weak)IBOutlet UIButton *submitBtn;
@property(nonatomic,weak)IBOutlet UIButton *sendMsgBtn;
@property(nonatomic,weak)IBOutlet UILabel *countDownLabel;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;

@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@end

@implementation YUUProfileAuthenEditeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeView = textField;
//    if (textField != self.phoneField) {
        self.activeView = _submitBtn;
//    }
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
-(IBAction)sendVerifyCode:(id)sender{
    if (self.prePhoneField.text.length == 0) {
        [HUD showHUDTitle:@"预留手机号不能为空" durationTime:2];
        return;
    }
    
    if (isMobileValid(self.prePhoneField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    [self setBusyIndicatorVisible:YES];
    YUUSendMessageRequest *sendMsg = [[YUUSendMessageRequest alloc]initWithSendMessage:[NSNumber numberWithInt:[self.prePhoneField.text intValue]] SuccessCallback:^(YUUBaseRequest *request) {
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
    }
    else{
        self.countDownLabel.text = [NSString stringWithFormat:@"%d",countNum];
    }
}
-(IBAction)submitAction:(id)sender{
    
    if (self.nameField.text.length == 0) {
        [HUD showHUDTitle:@"姓名不能为空" durationTime:2];
        return;
    }
    
    if (self.idCardField.text.length == 0) {
        [HUD showHUDTitle:@"身份证号不能为空" durationTime:2];
        return;
    }
    
    if (self.bankField.text.length == 0) {
        [HUD showHUDTitle:@"银行卡号不能为空" durationTime:2];
        return;
    }
    
    if (self.prePhoneField.text.length == 0) {
        [HUD showHUDTitle:@"预留手机号不能为空" durationTime:2];
        return;
    }
    
    if (self.messageCode.text.length == 0) {
        [HUD showHUDTitle:@"验证码不能为空" durationTime:2];
        return;
    }
    
    
    if (isMobileValid(self.prePhoneField.text) == false) {
        [HUD showHUDTitle:@"输入手机号有误" durationTime:2];
        return;
    }
    
    [self setBusyIndicatorVisible:YES];
    
    NSString *token = [YUUUserData shareInstance].userModel.token;
    
    YUUCertificationRequest *auth = [[YUUCertificationRequest alloc]initWithCertification:self.nameField.text Membercardid:self.idCardField.text Bankcard:[NSNumber numberWithInt:[self.bankField.text intValue]] Bankphone:[NSNumber numberWithInt:[self.prePhoneField.text intValue]] Code:self.messageCode.text Token:token SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUCommonModel *m = [request getResponse].data;
        [[YUUUserData shareInstance] saveUserData:m];
        [[YUUUserData shareInstance] getUserData];
        
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
//                [HUD showHUDTitle:res.msg durationTime:2];
                break;
            case 1:
                DLOG(@"无效token");
//                [HUD showHUDTitle:res.msg durationTime:2];
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];

    }];
    [auth start];
}

-(void)dealloc{
    DLOG(@"释放YUUProfileAuthenEditeCtrl页面");
    [countDownTimer invalidate];
    countDownTimer = nil;
    
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
