//
//  YUUMinePoolCell.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMinePoolCell.h"
#import "Header.h"

@implementation YUUMinePoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = YUUYellow;
    self.bgView.alpha = 0.15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUUserModel *)model {
    _model = model;
    
    _icon.image = [UIImage imageNamed:@"default_icon"];
    _idLabel.text = [NSString stringWithFormat:@"ID%@", model.userId];
    if (model.uerLevel == YUUUserLevelNew) {
        _levelLabel.text = @"新手矿工";
    }
    _powerLabel.text = [NSString stringWithFormat:@"算力: %ld",(long)model.power];
    _machineCountLabel.text = [NSString stringWithFormat:@"矿机: %ld台",(long)model.machineCount];
    _directPushLabel.text = [NSString stringWithFormat:@"直推: %ld人",(long)model.directPush];
    _teamCountLabel.text = [NSString stringWithFormat:@"团队: %ld人",(long)model.groupNumberCount];
}

@end
