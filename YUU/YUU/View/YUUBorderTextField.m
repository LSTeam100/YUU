//
//  YUUBorderTextField.m
//  YUU
//
//  Created by boli on 2018/8/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBorderTextField.h"

@implementation YUUBorderTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.enabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1;
    
    self.textColor = [UIColor whiteColor];
}

- (void)setText:(NSString *)text {
    text = [NSString stringWithFormat:@"   %@",text];
    [super setText:text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
