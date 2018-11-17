//
//  RankCell.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.borderColor = YUUBolderColor.CGColor;
    _bgView.layer.borderWidth = 1;
    
    _label0.textColor = YUUBolderColor;
    _label1.textColor = YUUBolderColor;
    _label2.textColor = [UIColor R:255 G:166 B:40];
    _label3.textColor = [UIColor R:255 G:166 B:40];
}

- (void)setModel:(RankModel *)model {
    _model = model;
    _label0.text = [NSString stringWithFormat:@"%ld",model.memberid];
//    _label0.text = [NSString stringWithFormat:@"%ld",model.memberid];
    _label2.text = [NSString stringWithFormat:@"%.0f",model.getyuu];
    _label3.text = [NSString stringWithFormat:@"%.0f",model.weekintegral];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    if (index >= 0 && index <= 2) {
        _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%ld",_index+1]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
