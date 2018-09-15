//
//  UIPickerView+Help.m
//  SHParent
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "UIPickerView+Help.h"

@implementation UIPickerView (Help)

- (void)hideSpearatorLine {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 1) {
            obj.hidden = YES;
        }
    }];
}


@end
