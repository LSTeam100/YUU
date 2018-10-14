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

//-(void)naviTologin{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
//    [self presentViewController:navi animated:YES completion:^{
//        DLOG(@"展示登录页面");
//    }];
//}

//-(BOOL)handleResponseError:(YUUSuperCtrl *)currentController
//                   request:(YUUBaseRequest *)request
//       needToken:(BOOL) token{
//    YUUResponse *res = [request getResponse];
//    int statusCode=[request getResponse].code;
//    if (token == true) {
//        switch (statusCode) {
//            case 1:
//                [self naviTologin];
//                break;
//            case 4:
//                showCostomAlert(@"closeMarket_alert", self.view.frame);
//                [self naviTologin];
//                break;
//            default:
//                [HUD showHUDTitle:res.msg durationTime:2];
//                break;
//        }
//    
//    }
//    else{
//        switch (statusCode) {
//            case 4:
//                [self naviTologin];
//                break;
//            default:
//                [HUD showHUDTitle:res.msg durationTime:2];
//                break;
//        }
//    }
//    return NO;
//}
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
