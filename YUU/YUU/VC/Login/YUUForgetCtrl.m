//
//  YUUForgetCtrl.m
//  YUU
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUForgetCtrl.h"

@interface YUUForgetCtrl ()<UITextFieldDelegate>
{
    
}
@property(nonatomic,weak)IBOutlet UITextField *phoneTextField;
@property(nonatomic,weak)IBOutlet UITextField *codeTextField;
@property(nonatomic,weak)IBOutlet UITextField *passwordField;
@property(nonatomic,weak)IBOutlet UITextField *resetPasswordField;
@property(nonatomic,weak)IBOutlet UIButton *submitBtn;
@end

@implementation YUUForgetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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