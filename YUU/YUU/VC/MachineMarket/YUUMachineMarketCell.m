//
//  YUUMachineMarketCell.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMachineMarketCell.h"

@implementation YUUMachineMarketCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    [_buyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 4)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUMachineModel *)model {
    _model = model;
    _icon.image = [UIImage imageNamed:model.icon];
    _nameLabel.text = model.name.length > 0 ? model.name : @" ";
    _ComputingPowerLabel.text = [NSString stringWithFormat:@"算力: %ld",(long)model.compower];
    _cycleLabel.text = [NSString stringWithFormat:@"运行周期: %ld天",(long)model.totaldays];
    _incomeLabel.text = [NSString stringWithFormat:@"收益总量: %0.1f",model.totalcoins];
//    [_buyBtn setTitle:[NSString stringWithFormat:@"%ldYUU",model.price] forState:UIControlStateNormal];
    _priceLabel.text = [NSString stringWithFormat:@"%ldYUU",model.millprice];
}


- (IBAction)buyBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(buyMachine:)]) {
        if (_model) {        
            [_delegate buyMachine:_model];
        }
    }
}



@end
