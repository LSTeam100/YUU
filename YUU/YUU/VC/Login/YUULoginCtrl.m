//
//  YUULoginCtrl.m
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUULoginCtrl.h"

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
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
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
- (void)moveUp:(float)shift{
    self.cstTopMargin.constant -= shift;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)reover{
    [UIView animateWithDuration:0.2 animations:^{
        
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
    return  true;
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
