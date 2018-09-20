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

- (void)setModel:(YUUMilltraderModel *)model {
    _model = model;
    _icon.image = [UIImage imageNamed:[model iconName]];
    _nameLabel.text = [model typeName];
    _ComputingPowerLabel.text = [NSString stringWithFormat:@"算力: %@",model.compower];
    _cycleLabel.text = [NSString stringWithFormat:@"运行周期: %@天",model.totaldays];
    _incomeLabel.text = [NSString stringWithFormat:@"收益总量: %@",model.totalcoins];
//    [_buyBtn setTitle:[NSString stringWithFormat:@"%@YUU",model.millprice] forState:UIControlStateNormal];
    _priceLabel.text = [NSString stringWithFormat:@"%@YUU",model.millprice];
}


- (IBAction)buyBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(buyMachine:)]) {
        if (_model) {        
            [_delegate buyMachine:_model];
        }
    }
}



@end
