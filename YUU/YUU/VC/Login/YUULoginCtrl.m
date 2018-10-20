//
//  YUULoginCtrl.m
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUULoginCtrl.h"
#import "YUUSignUpCtrl.h"
#import "YUULoginRequest.h"
#import "HUDManager.h"
#import "YUUCommonModel.h"
#import "YUUUserData.h"
#import "YUUForgetCtrl.h"
#import "YUUTabBarController.h"
@interface YUULoginCtrl ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *account;
    IBOutlet UITextField *passworad;
    IBOutlet UIButton *btnSignIn;
    CGFloat originInputTopMargin;

}
@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;
@end

@implementation YUULoginCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    DLOG(@"YUULoginCtrl viewDidLoad");

    UIColor *color = [UIColor whiteColor];
    account.attributedPlaceholder = [[NSAttributedString alloc] initWithString:account.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    passworad.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passworad.placeholder attributes:@{NSForegroundColorAttributeName: color}];

    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
    }];
    
//    if ([YUUUserData shareInstance].userModel.token.length > 0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
//    }
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    originInputTopMargin = self.cstTopMargin.constant;
    [self registerKeyboardNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self unregisterKeyboardNotification];
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeView = textField;
    if (textField == passworad) {
        self.activeView = btnSignIn;
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == account) {
        
    }
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
    
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
        
    }
    return  true;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"forgetPassword"]) {
        YUUForgetCtrl *forget = segue.destinationViewController;
        forget.forgetType = forgetLoginType;        
    }
    
}

-(IBAction)login:(id)sender{
    
    if (account.text.length == 0) {
        [[HUDManager manager] showHUDTitle:@"用户名不能为空" durationTitme:2];
        return;
    }
    
    if(passworad.text.length == 0){
        [[HUDManager manager] showHUDTitle:@"密码不能为空" durationTitme:2];

        return;

    }
    
//    if (isMobileValid(account.text) == false) {
//        [[HUDManager manager] showHUDTitle:@"输入手机号有误" durationTitme:2];
//        return;
//    }
    
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    WeakSelf
    [self setBusyIndicatorVisible:YES];
    YUULoginRequest *req = [[YUULoginRequest alloc]initWithMobilePhone:account.text Password:passworad.text SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUCommonModel *login = [request getResponse].data;
        [[YUUUserData shareInstance] saveUserData:login];
//        [self dismissViewControllerAnimated:YES completion:^{
//            DLOG(@"关闭登录页面");
//            if ([root isKindOfClass:[YUUTabBarController class]]) {
//                YUUTabBarController *tabbar = (YUUTabBarController *)root;
//                [tabbar setSelectedIndex:4];
//                
//            }
//
//        }];
        
        [account resignFirstResponder];
        [passworad resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [weakSelf handleResponseError:self request:request needToken:false];
//        YUUResponse *res = [request getResponse];
//        switch (res.code) {
//            case 0:
//                DLOG(@"用户锁定");
//                showCostomAlert(@"local_alert", weakSelf.view.frame);
//                break;
//            case 1:
//                DLOG(@"需要提示用户错误信息");
//                [[HUDManager manager] showHUDTitle:res.msg durationTitme:2];
//                break;
//            case 3:
//                DLOG(@"闭市");
//                showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);
//                break;
//            default:
//                [[HUDManager manager] showHUDTitle:res.msg durationTitme:2];
//                break;
//        }
//        [weakSelf handleResponseError:weakSelf request:request needToken:false];
    }];
    [req start];
    
    
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
