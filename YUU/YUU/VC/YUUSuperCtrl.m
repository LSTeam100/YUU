//
//  YUUSuperCtrl.m
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface YUUSuperCtrl ()

@end

@implementation YUUSuperCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
