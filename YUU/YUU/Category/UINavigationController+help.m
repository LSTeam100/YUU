//
//  UINavigationController+help.m
//  YUU
//
//  Created by boli on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UINavigationController+help.h"

@implementation UINavigationController (help)

// 重写这两个方法，可以使 viewController 调用 - (UIStatusBarStyle)preferredStatusBarStyle
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

@end
