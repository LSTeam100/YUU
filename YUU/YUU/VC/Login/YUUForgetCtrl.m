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
@interface YUUForgetCtrl ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat originInputTopMargin;
    
}
@property(nonatomic,weak)IBOutlet UITextField *phoneTextField;
@property(nonatomic,weak)IBOutlet UITextField *codeTextField;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;
@property(nonatomic,weak)IBOutlet UITextField *resetPasswordField;
@property(nonatomic,weak)IBOutlet UIButton *submitBtn;
@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;

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
