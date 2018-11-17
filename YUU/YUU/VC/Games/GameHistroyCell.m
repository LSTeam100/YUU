//
//  GameHistroyCell.m
//  YUU
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameHistroyCell.h"

@implementation GameHistroyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = colorWithHexString(@"52B2C6", 1.0);
    self.otherIdLabel.textColor = colorWithHexString(@"52B2C6", 1.0);
    self.firYuuLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.secYuuLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.thiYuuLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.firPohintLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.secPohintLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.thiPohintLabel.textColor = colorWithHexString(@"ffa628", 1.0);
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.borderColor = [colorWithHexString(@"52B2C6", 1.0) CGColor];
    self.bgView.layer.borderWidth = 1.0;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
