//
//  GameYUUListCell.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameYUUListCell.h"

@implementation GameYUUListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.borderWidth = 1;
}

- (void)setColor:(UIColor *)color {
    _bgView.layer.borderColor = color.CGColor;
    _label.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
