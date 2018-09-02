//
//  YUUModifyPassword.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUModifyPassword.h"
#import "YUUForgetCtrl.h"
@interface YUUModifyPassword ()
@property(nonatomic,weak)IBOutlet UITextField *oldField;
//@property(nonatomic,weak)IBOutlet UITextField *newField;
@property(nonatomic,weak)IBOutlet UIButton *forgetTransactionBtn;

@end

@implementation YUUModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.navigationController pushViewController:forget animated:YES];
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
