//
//  HUD.m
//  FamilyGuard
//
//  Created by boli on 2018/7/25.
//  Copyright © 2018年 Mars. All rights reserved.
//

#import "HUD.h"
#import "HUDManager.h"

@implementation HUD

+ (void)showHTTPMessage:(NSString *)message {
    if (message) {
        [HUD showHUDTitle:message durationTime:2];
    } else {
        [HUD hide];
    }
}

+ (void)showHUDDelay {
    [HUD hide];
    [[HUDManager manager] showHUDDelay];
}

+ (void)showHUDDelayTitle:(NSString *)title {
    [HUD hide];
    if (!title || title.length == 0) {
        [HUD showHUD];
        return ;
    }
    [[HUDManager manager] showHUDDelayTitle:title];
}

+ (void)showHUDTitle:(NSString *)title durationTime:(NSInteger)time {
    [HUD hide];
    if (!title || title.length == 0) {
        return ;
    }
    [[HUDManager manager] showHUDTitle:title durationTitme:time mode:MBProgressHUDModeText];
}

+ (void)showHUDTitle:(NSString *)title durationTime:(NSInteger)time mode:(MBProgressHUDMode)mode {
    [HUD hide];
    [[HUDManager manager] showHUDTitle:title durationTitme:time mode:mode];
}

+ (void)showHUD {
    [HUD hide];
    [[HUDManager manager] showHUD];
}

+ (void)showHUDTitle:(NSString *)title {
    [HUD hide];
    if (!title || title.length == 0) {
        [HUD showHUD];
        return ;
    }
    [[HUDManager manager] showHUDTitle:title mode:MBProgressHUDModeText];
}

+ (void)showHUDTitle:(NSString *)title mode:(MBProgressHUDMode)mode {
    [HUD hide];
    [[HUDManager manager] showHUDTitle:title mode:mode];
}

+ (void)showHUDDelayAddedTo:(UIView *)view {
    [HUD hide];
    [[HUDManager manager] showHUDDelayAddedTo:view];
}

+ (void)showHUDAddedTo:(UIView *)view {
    [HUD hide];
    [[HUDManager manager] showHUDAddedTo:view];
}

+ (void)showHUDAddedTo:(UIView *)view title:(NSString *)title {
    [HUD hide];
    [[HUDManager manager] showHUDAddedTo:view title:title mode:MBProgressHUDModeText];
}

+ (void)showHUDAddedTo:(UIView *)view title:(NSString *)title mode:(MBProgressHUDMode)mode {
    [HUD hide];
    [[HUDManager manager] showHUDAddedTo:view title:title mode:mode];
}

+ (void)hide {
    [[HUDManager manager] hide];
}

+ (void)showCustomView:(UIView *)customView {
    [[HUDManager manager] showCustomView:customView];
}

+ (void)showRequest:(YUUBaseRequest *)request {
    if (request.getResponse.msg.length > 0) {
        [HUD showHUDTitle:request.getResponse.msg durationTime:2];
    } else {
        [HUD hide];
    }
}

@end
