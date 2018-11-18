//
//  OffensiveAndDefensiveOrderCell.m
//  YUU
//
//  Created by boli on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "OffensiveAndDefensiveOrderCell.h"

@implementation OffensiveAndDefensiveOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _hasNewRecordIcon.backgroundColor = [UIColor redColor];
    _hasNewRecordIcon.layer.masksToBounds = YES;
    _hasNewRecordIcon.layer.cornerRadius = _hasNewRecordIcon.frame.size.width/2;
    _hasNewRecordIcon.hidden = YES;
    _hasNewRecordLabel.textColor = [UIColor redColor];
    _hasNewRecordLabel.hidden = YES;
}

- (void)setHasNewRecord:(BOOL)hasNewRecord {
    _hasNewRecord = hasNewRecord;
    if (hasNewRecord) {
        _hasNewRecordIcon.hidden = NO;
        _hasNewRecordLabel.hidden = NO;
    } else {
        _hasNewRecordIcon.hidden = YES;
        _hasNewRecordLabel.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setColor:(UIColor *)color {
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderColor = color.CGColor;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor clearColor];
    _label.textColor = color;
}

@end
