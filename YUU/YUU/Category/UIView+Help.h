//
//  UIView+Help.h
//  APPHelp
//
//  Created by boli on 2018/8/8.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Help)

- (void)setCornerRadius:(CGFloat)radius;

- (CGFloat)left;

- (CGFloat)right;

- (CGSize)size;

- (CGFloat)top;

- (CGFloat)bottom;

- (CGFloat)width;

- (CGFloat)height;

- (CGFloat)centerX;

- (CGFloat)centerY;

- (void)setLeft:(CGFloat)left;

- (void)setRight:(CGFloat)right;

- (void)setSize:(CGSize)size;

- (void)setTop:(CGFloat)top;

- (void)setBottom:(CGFloat)bottom;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setCenterX:(CGFloat)centerX;

- (void)setCenterY:(CGFloat)centerY;

- (void)setOrigin:(CGPoint)point;

- (void)showShadow;

@end
