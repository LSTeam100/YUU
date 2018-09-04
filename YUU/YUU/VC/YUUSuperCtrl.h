//
//  YUUSuperCtrl.h
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUUBaseViewController.h"
#import "YUUBaseRequest.h"

@interface YUUSuperCtrl : YUUBaseViewController
-(void)moveUp:(float)shift;
-(void)reover;
-(void)registerKeyboardNotification;
-(void)unregisterKeyboardNotification;
-(void)handleTap:(UIGestureRecognizer *)gesture;

-(BOOL)handleResponseError:(YUUSuperCtrl *)currentController
                   request:(YUUBaseRequest *)request
       treatErrorAsUnknown:(BOOL) treated;
-(void)setBusyIndicatorVisible:(BOOL)visible;
@property(nonatomic,strong)UIView *activeView;

@end
