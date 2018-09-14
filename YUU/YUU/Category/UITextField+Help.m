//
//  UITextField+Help.m
//  SHParent
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "UITextField+Help.h"
#import <objc/runtime.h>

@implementation UITextField (Help)

static void *kMaxLength = &kMaxLength;

- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, kMaxLength, @(maxLength), OBJC_ASSOCIATION_COPY);
    
    if (maxLength > 0) {
        [self addTarget:self action:@selector(H_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    } else {
        [self removeTarget:self action:@selector(H_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }
}

- (NSInteger)maxLength {
    return [objc_getAssociatedObject(self, kMaxLength) unsignedIntegerValue];
}

- (void)H_valueChanged:(UITextField *)textField {
    if (self.maxLength == 0) return;
    if ([textField.text length] <= self.maxLength) return;
    
    NSString *subString = [textField.text substringToIndex:self.maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
        textField.text = subString;
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    });
}

- (void)setPlaceholderColor:(UIColor *)color {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:
                                      @{NSForegroundColorAttributeName:color,
                                        NSFontAttributeName:self.font
                                        }];
    self.attributedPlaceholder = attrString;
}

@end
