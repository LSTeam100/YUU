//
//  HUDManager.m
//  FamilyGuard
//
//  Created by boli on 2018/7/25.
//  Copyright © 2018年 Mars. All rights reserved.
//

#import "HUDManager.h"

@implementation HUDManager

static HUDManager *manager = nil;

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HUDManager alloc] init];
    });
    
    return manager;
}

- (void)showHUDDelay {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showHUD) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)showHUDDelayTitle:(NSString *)title {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hud) {
            [weakSelf.timer invalidate];
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showTitle:) userInfo:@{@"title":title} repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
        } else {
            [self showHUDTitle:title mode:MBProgressHUDModeIndeterminate];
        }
    });
}

- (void)showHUDTitle:(NSString *)title durationTitme:(NSInteger)time {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showHUDTitle:title durationTitme:time mode:MBProgressHUDModeText];
    });
}

- (void)showHUDTitle:(NSString *)title durationTitme:(NSInteger)time mode:(MBProgressHUDMode)mode {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        if (!mode) {
            weakSelf.hud.mode = MBProgressHUDModeText;
        } else {
            weakSelf.hud.mode = mode;
        }
        
        weakSelf.hud.label.text = title;
        [weakSelf.hud hideAnimated:YES afterDelay:time];
    });
}

- (void)showHUD {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    });
}

- (void)showHUDTitle:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showHUDTitle:title mode:MBProgressHUDModeText];
    });
}

- (void)showHUDTitle:(NSString *)title mode:(MBProgressHUDMode)mode {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        weakSelf.hud.mode = mode;
        weakSelf.hud.label.text = title;
    });
}

- (void)showHUDDelayAddedTo:(UIView *)view {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.timer invalidate];
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showHUDAddedTo:) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
    });
}

- (void)showHUDAddedTo:(UIView *)view {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    });
}

- (void)showHUDAddedTo:(UIView *)view title:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showHUDAddedTo:view title:title mode:MBProgressHUDModeText];
    });
}

- (void)showHUDAddedTo:(UIView *)view title:(NSString *)title mode:(MBProgressHUDMode)mode {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        if (!mode) {
            weakSelf.hud.mode = MBProgressHUDModeText;
        } else {
            weakSelf.hud.mode = mode;
        }
        weakSelf.hud.label.text = title;
    });
}

- (void)hide {
    __weak __typeof__(self) weakSelf = self;
    [_timer invalidate];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.hud hideAnimated:YES];
    });
}

- (void)showTitle:(NSTimer *)timer {
    [self showHUDTitle:[timer.userInfo objectForKey:@"title"] mode:MBProgressHUDModeIndeterminate];
}

- (void)showCustomView:(UIView *)customView {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        weakSelf.hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        weakSelf.hud.mode = MBProgressHUDModeCustomView;
        weakSelf.hud.bezelView.color = [UIColor clearColor];
        weakSelf.hud.backgroundView.color = [UIColor grayColor];
        weakSelf.hud.backgroundView.alpha = 0.3;
        weakSelf.hud.customView = customView;
        
        for (UIView *view in weakSelf.hud.subviews) {
            for (UIView *aview in view.subviews) {
                if ([aview isKindOfClass:[UIVisualEffectView class]]) {
                    aview.hidden = YES;
                }
            }
        }
    });
}

@end
