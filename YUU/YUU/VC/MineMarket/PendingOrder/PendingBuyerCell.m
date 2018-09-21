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
    [_middleBtn setTitleColor:[UIColor hex:@"ff2a00"] forState:UIControlStateNormal];
    
    _numberLabel.textColor = YUUYellow;
    _timeLabel.textColor = [UIColor whiteColor];
    _contentLabel.textColor = [UIColor whiteColor];
    
    _bgView.backgroundColor = [UIColor hex:@"e4c177" alpha:0.1];
}

- (void)setModel:(YUUPendingBuyerModel *)model {
    _model = model;
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = _middleBtn.frame.size.height/2;
    _middleBtn.layer.borderColor = [[UIColor hex:@"ff2a00"] CGColor];
    _middleBtn.layer.borderWidth = 1;
    
    _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
    _contentLabel.text = @"内容";
}

@end
