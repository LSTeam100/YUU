//
//  PendingTableViewCell.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PendingBuyerCell.h"

@implementation PendingBuyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_middleBtn setTitle:@"卖给他" forState:UIControlStateNormal];
    [_middleBtn setTitleColor:[UIColor R:160.0 G:69.0 B:22.0] forState:UIControlStateNormal];
    
    _numberLabel.textColor = YUUYellow;
    _timeLabel.textColor = [UIColor whiteColor];
    _contentLabel.textColor = [UIColor whiteColor];
}

- (void)setModel:(YUUPendingBuyerModel *)model {
    _model = model;
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = _middleBtn.frame.size.height/2;
    _middleBtn.layer.borderColor = [[UIColor R:160.0 G:69.0 B:22.0] CGColor];
    _middleBtn.layer.borderWidth = 1;
    
    _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
    _contentLabel.text = @"内容";
}

@end
