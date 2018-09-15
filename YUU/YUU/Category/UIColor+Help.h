//
//  UIColor+Help.h
//  APPHelp
//
//  Created by boli on 2018/8/8.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Help)

+ (UIColor *)hex:(NSString *)hexString;

+ (UIColor *)hex:(NSString *)hexString alpha:(float)alpha;

+ (UIColor *)R:(float)r G:(float)g B:(float)b;

@end
