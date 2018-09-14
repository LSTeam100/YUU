//
//  YUUMineralPoolCell.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMineralPoolCell.h"
#import "Header.h"

@implementation YUUMineralPoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = YUUYellow;
    self.bgView.alpha = 0.15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUMachinePoolModel *)model {
    _model = model;
    
    _icon.image = [UIImage imageNamed:@"default_icon"];
    _idLabel.text = [NSString stringWithFormat:@"ID%@", model.memberid];
//    if (model.uerLevel == YUUUserLevelNew) {
//        _levelLabel.text = @"新手矿工";
//    }
    _levelLabel.text = model.membergrade;
    _powerLabel.text = [NSString stringWithFormat:@"算力: %@",model.memberpower];
    _machineCountLabel.text = [NSString stringWithFormat:@"矿机: %@台", model.membertotalmills];
    _directPushLabel.text = [NSString stringWithFormat:@"直推: %@人", model.membertotaldirect];
    _teamCountLabel.text = [NSString stringWithFormat:@"团队: %@人", model.membertotalnodirect];
}

@end
