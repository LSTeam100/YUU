//
//  YUUMineMachineCell.m
//  YUU
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMachineCell.h"

@implementation YUUMineMachineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUMachineDetailModel *)model {
    _model = model;
    
    _statusView.layer.masksToBounds = YES;
    _statusView.layer.cornerRadius = _statusView.frame.size.width/2;
    _numberLabel.text = model.millsize;
    _typeLabel.text = _model.milltypeName;
    _operationLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.runtimeday, (long)model.totaldays];
    _powerLabel.text = [NSString stringWithFormat:@"%ld", (long)model.compower];
    _outputLabel.text = [NSString stringWithFormat:@"%.2f", [model.outputcoins doubleValue]];
    if (model.getmill == YUUMachineReceiveNo) {
        _receiveLabel.text = @"未领取";
    } else {
        _receiveLabel.text = @"已领取";
    }
}

@end
