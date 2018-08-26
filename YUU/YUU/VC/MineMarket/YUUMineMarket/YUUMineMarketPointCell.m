//
//  YUUMineMarketPointCell.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketPointCell.h"

@implementation YUUMineMarketPointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_noticeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_noticeBtn setTitle:@"点对点交易须知" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sellBtnAction:(UIButton *)sender {
}

- (IBAction)noticeBtnAction:(id)sender {
}



@end
