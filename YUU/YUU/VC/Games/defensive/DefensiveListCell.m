//
//  DefensiveListCell.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "DefensiveListCell.h"
#import "YUUConfig.h"

@implementation DefensiveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.borderColor = YUUBolderColor.CGColor;
    _bgView.layer.borderWidth = 1;
    
    _label0.textColor = [UIColor R:70 G:107 B:121];;
    _label1.textColor = YUUBolderColor;
    _label2.textColor = YUUBolderColor;
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)challengeAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(challengeSelected:)]) {
        [_delegate challengeSelected:self];
    }
}




- (void)setModel:(DefensiveListModel *)model {
    _model = model;
    
    _label0.text = [NSString stringWithFormat:@"%ld",model.memberid];
    _label1.text = regYUUCoin([NSNumber numberWithDouble:(model.putyuu)], 2);
    
    _label2.text = @"防守中";
}


@end
