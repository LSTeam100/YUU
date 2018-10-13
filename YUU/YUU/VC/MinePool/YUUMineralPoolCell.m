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

- (void)setDirectModel:(DirectPushModel *)directModel {
    _icon.image = [UIImage imageNamed:@"default_icon"];
    _idLabel.text = [NSString stringWithFormat:@"ID:%ld", (long)directModel.memberid];
    //    if (model.uerLevel == YUUUserLevelNew) {
    //        _levelLabel.text = @"新手矿工";
    //    }
    _levelLabel.text = directModel.membergrade;
    _icon.image = getHeadPhoto(directModel.membergrade);
    
    
    _powerLabel.text = [NSString stringWithFormat:@"算力: %ld",(long)directModel.memberpower];
    _machineCountLabel.text = [NSString stringWithFormat:@"矿机: %ld台", (long)directModel.membertotalmills];
    _directPushLabel.text = [NSString stringWithFormat:@"直推: %ld人", (long)directModel.membertotaldirect];
    _teamCountLabel.text = [NSString stringWithFormat:@"团队: %ld人", (long)directModel.membertotalnodirect];
}

- (void)setTeamModel:(TeamPushModel *)teamModel {
    _icon.image = [UIImage imageNamed:@"default_icon"];
    _idLabel.text = [NSString stringWithFormat:@"ID%ld", (long)teamModel.memberid];
    //    if (model.uerLevel == YUUUserLevelNew) {
    //        _levelLabel.text = @"新手矿工";
    //    }
    _levelLabel.text = teamModel.membergrade;
    _powerLabel.text = [NSString stringWithFormat:@"算力: %ld",(long)teamModel.memberpower];
    _machineCountLabel.text = [NSString stringWithFormat:@"矿机: %ld台", (long)teamModel.membertotalmills];
    _directPushLabel.text = [NSString stringWithFormat:@"直推: %ld人", (long)teamModel.membertotaldirect];
    _teamCountLabel.text = [NSString stringWithFormat:@"团队: %ld人", (long)teamModel.membertotalnodirect];
}


@end
