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

- (void)setModel:(YUUMachineModel *)model {
    _model = model;
    
    _statusView.layer.masksToBounds = YES;
    _statusView.layer.cornerRadius = _statusView.frame.size.width/2;
    _numberLabel.text = model.machineNumber;
    if (model.type == YUUMachineTypeNew) {
        _typeLabel.text = @"新手";
    }
    _operationLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.operationDay, (long)model.operationCycle];
    _powerLabel.text = [NSString stringWithFormat:@"%ld", (long)model.power];
    _outputLabel.text = [NSString stringWithFormat:@"%.2f", model.output];
    if (model.receive == YUUMachineReceiveNo) {
        _receiveLabel.text = @"未领取";
    } else {
        _receiveLabel.text = @"已领取";
    }
}

@end