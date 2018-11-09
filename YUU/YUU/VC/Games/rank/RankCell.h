//
//  RankCell.h
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "UIColor+Help.h"

typedef NS_ENUM(NSInteger, RankType) {
    week = 0,
    all = 1,
};

@interface RankCell : YUUBaseTableViewCell

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;


@end
