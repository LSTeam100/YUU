//
//  GameHistroyCell.h
//  YUU
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameHistroyCell : UITableViewCell
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *otherIdLabel;
@property(nonatomic,weak)UIImageView *firstIcon;
@property(nonatomic,weak)UIImageView *secIcon;
@property(nonatomic,weak)UIImageView *thirdIcon;
@property(nonatomic,weak)UILabel *firYuuLabel;
@property(nonatomic,weak)UILabel *secYuuLabel;
@property(nonatomic,weak)UILabel *thiYuuLabel;
@property(nonatomic,weak)UILabel *secPohintLabel;
@property(nonatomic,weak)UILabel *thiPohintLabel;
@property(nonatomic,weak)UIImageView *statusImageView;

@end
