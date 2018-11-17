//
//  GameHistroyCell.h
//  YUU
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameHistroyCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *timeLabel;
@property(nonatomic,weak)IBOutlet UILabel *otherIdLabel;
@property(nonatomic,weak)IBOutlet UIImageView *firstIcon;
@property(nonatomic,weak)IBOutlet UIImageView *secIcon;
@property(nonatomic,weak)IBOutlet UIImageView *thirdIcon;
@property(nonatomic,weak)IBOutlet UILabel *firYuuLabel;
@property(nonatomic,weak)IBOutlet UILabel *secYuuLabel;
@property(nonatomic,weak)IBOutlet UILabel *thiYuuLabel;
@property(nonatomic,weak)IBOutlet UILabel *firPohintLabel;
@property(nonatomic,weak)IBOutlet UILabel *secPohintLabel;
@property(nonatomic,weak)IBOutlet UILabel *thiPohintLabel;
@property(nonatomic,weak)IBOutlet UIImageView *statusImageView;
@property(nonatomic,weak)IBOutlet UIView *bgView;

@end
