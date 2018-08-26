//
//  HUD.h
//  FamilyGuard
//
//  Created by boli on 2018/7/25.
//  Copyright © 2018年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUD : NSObject

+ (void)showHTTPMessage:(NSString *)message;

+ (void)showHUDDelay;

+ (void)showHUDDelayTitle:(NSString *)title;

+ (void)showHUDTitle:(NSString *)title durationTime:(NSInteger)time;

+ (void)showHUDTitle:(NSString *)title durationTime:(NSInteger)time mode:(MBProgressHUDMode)mode;

+ (void)showHUD;

+ (void)showHUDTitle:(NSString *)title;

+ (void)showHUDTitle:(NSString *)title mode:(MBProgressHUDMode)mode;

+ (void)showHUDDelayAddedTo:(UIView *)view;

+ (void)showHUDAddedTo:(UIView *)view;

+ (void)showHUDAddedTo:(UIView *)view title:(NSString *)title;

+ (void)showHUDAddedTo:(UIView *)view title:(NSString *)title mode:(MBProgressHUDMode)mode;

+ (void)hide;

+ (void)showCustomView:(UIView *)customView;

@end
