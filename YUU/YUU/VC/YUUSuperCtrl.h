//
//  YUUSuperCtrl.h
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUUSuperCtrl : UIViewController
-(void)moveUp:(float)shift;
-(void)reover;
-(void)registerKeyboardNotification;
-(void)unregisterKeyboardNotification;
-(void)handleTap:(UIGestureRecognizer *)gesture;
@property(nonatomic,strong)UIView *activeView;

@end
