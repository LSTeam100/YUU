//
//  UIViewController+Help.m
//  APPHelp
//
//  Created by boli on 2018/8/7.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "UIViewController+Help.h"

@implementation UIViewController (Help)

+ (UIViewController *)currentViewController
{
    UIViewController *currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    while ([currentViewController presentedViewController])    currentViewController = [currentViewController presentedViewController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]
        && ((UITabBarController*)currentViewController).selectedViewController != nil )
    {
        currentViewController = ((UITabBarController*)currentViewController).selectedViewController;
    }
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController*)currentViewController topViewController])
    {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    
    return currentViewController;
}

+ (void)alertTitle:(NSString *)title
           message:(NSString *)message
         determine:(NSString *)determine
            cancel:(NSString *)cancel
  determineHandler:(void (^)(void))determineHandler
     cancelHandler:(void (^)(void))cancelHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        if (cancelHandler) {
            cancelHandler();
        }
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:determine style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (determineHandler) {
            determineHandler();
        }
    }];
    if (cancel) {
        [alert addAction:cancelAction];
    }
    [alert addAction:sureAction];
    
    [[UIViewController currentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (void)alertTitle:(NSString *)title
           message:(NSString *)message
         determine:(NSString *)determine
  determineHandler:(void (^)(void))determineHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:determine style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (determineHandler) {
            determineHandler();
        }
    }];
    [alert addAction:sureAction];
    
    [[UIViewController currentViewController] presentViewController:alert animated:YES completion:nil];
}

@end
