//
//  DrawView.h
//  test
//
//  Created by boli on 2018/8/26.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic, strong) NSArray *leftTitles;

@property (nonatomic, strong) NSArray *bottomTitles;

@property (nonatomic, assign) NSInteger left;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, assign) NSInteger right;
@property (nonatomic, assign) NSInteger bottom;

@property (nonatomic, assign) NSInteger partLine; // 每段分割线长度

@property (nonatomic, assign) double maxLeft;
@property (nonatomic, strong) NSArray *numbers;

@property (nonatomic, strong) UIColor *lineColor;

@end
