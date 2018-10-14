//
//  YUUSuperCtrl.m
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"
#import "MBProgressHUD.h"
#import "YUULoginCtrl.h"
@interface YUUSuperCtrl (){
    int _busyCount;
}
@property (strong, nonatomic)MBProgressHUD *busyIndicator;

@end

@implementation YUUSuperCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomBackItem];
//    self.navigationController.navigationBar.topItem.title = @"";
    // Do any additional setup after loading the view.
}
-(void)handleTap:(UIGestureRecognizer *)gesture{
    [self.view endEditing:YES];
}
-(void)registerKeyboardNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unregisterKeyboardNotification{
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];


}


-(void)keyBoardWillShow:(NSNotification *)notif{
    NSDictionary *userdic = [notif userInfo];
    CGRect kbrect = [userdic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (self.activeView == nil) {
        return;
    }
    UIView *actv = self.activeView;
    
    CGPoint kp = [actv convertPoint:kbrect.origin fromView:self.view.window];
    float ret = actv.frame.size.height - kp.y;
    if (ret > 0) {
        [self moveUp:ret];
    }
}
-(void)moveUp:(float)shift{
    
}

-(void)keyboardWillHide:(NSNotification *)notif{
    [self reover];
}
-(void)reover{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBusyIndicatorVisible:(BOOL)visible{
    if(visible){
        _busyCount++;
        if(self.busyIndicator==nil){
            self.busyIndicator=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            self.busyIndicator.dimBackground=YES;
        }
    }else{
        _busyCount--;
        if(_busyCount==0 || _busyCount<0){
            _busyCount=0;
            [self.busyIndicator hide:YES];
            [self.busyIndicator removeFromSuperview];
            self.busyIndicator=nil;
        }
    }
}

-(void)naviTologin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
    [self presentViewController:navi animated:YES completion:^{
        DLOG(@"展示登录页面");
    }];
}

-(BOOL)handleResponseError:(YUUSuperCtrl *)currentController
                   request:(YUUBaseRequest *)request
       needToken:(BOOL) token{
    int statusCode=[request getResponse].code;
    if (token == true) {
        switch (statusCode) {
            case 1:
                [self naviTologin];
                break;
            case 4:
                [self naviTologin];
                break;
            default:
                break;
        }
    
    }
    else{
        switch (statusCode) {
            case 4:
                [self naviTologin];
                break;
            default:
                break;
        }
    }
    
    
//    if (treated) {
//        [self showDefaultFailureMessage];
//
//    }
//    if (statusCode == 0) {
//        <#statements#>
//    }
//    if(statusCode==430||statusCode==431){
//        [self handleSessionTimeout:currentController request:request];
//        return YES;
//    }
//        else if(statusCode==-100){
//        [self showMessage:[request getResponse].errorMessage];
//        return YES;
//    }
//    else if (statusCode==502)
//    {
//        [self showMessage:@"没有权限"];
//        return YES;
//    }
//    else if (statusCode==503)
//    {
//        [self showMessage:@"已存在该数据"];
//    }
//    else if(statusCode==504)
//    {
//        [self showMessage:@"数据库错误"];
//    }
//    else if (statusCode==505)
//    {
//        [self showMessage:@"密码错误"];
//    }
//    else if (statusCode==506)
//    {
//        [self showMessage:@"更新失败"];
//    }
//    else if (statusCode==516)
//    {
//        [self showMessage:@"库存不够"];
//    }
//    else if (statusCode==507)
//    {
//        [self showMessage:@"验证码错误"];
//    }
//    else if (statusCode==508)
//    {
//        [self showMessage:@"无权限"];
//    }
//    else if (statusCode==404)
//    {
//
//    }
//    else if (statusCode==450)
//    {
//        [self showMessage:@"该用户已存在"];
//    }
//    else if (statusCode==510)
//    {
//        [self showMessage:@"商铺歇业中"];
//    }
//    else if (statusCode==511)
//    {
//        [self showMessage:@"当前城市不支持"];
//    }
//    else{
//        if(treated){
//            [self showDefaultFailureMessage];
//            return YES;
//        }
//    }
    return NO;
}
-(void)showCloesdMarket:(YUUSuperCtrl *)ctrl Content:(NSString *)content{
    [self presentViewController:ctrl animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];

}
-(void)showDefaultFailureMessage{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"" message:@"操作失败" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showMessage:(NSString *)message{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
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
