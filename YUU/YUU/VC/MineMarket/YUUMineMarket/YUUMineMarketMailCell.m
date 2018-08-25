//
//  YUUMineMarketMailCell.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketMailCell.h"

@implementation YUUMineMarketMailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = 10;
    _middleBtn.layer.borderWidth = 1;
    _middleBtn.backgroundColor = [UIColor clearColor];
    
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0.3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUTransactionModel *)model {
    _model = model;
    
    // TODO: 自己是卖家还是卖家判断
    if (1) {
        _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.number];
        _timeLabel.text = model.time;
        _contentLabel.text = model.content;
        
        _leftBtn.hidden = YES;
        _rightBtn.hidden = YES;
        // TODO: 判断状态
        _middleBtn.layer.borderColor = [[UIColor greenColor] CGColor];
        [_middleBtn setTitle:@"确认交易" forState:UIControlStateNormal];
        [_middleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"买家资料"]) {
        
    } else if ([title isEqualToString:@"卖家资料"]) {
        
    } else if ([title isEqualToString:@"确认交易"]) {
        
    } else if ([title isEqualToString:@"取消交易"]) {
        
    }
}






@end
