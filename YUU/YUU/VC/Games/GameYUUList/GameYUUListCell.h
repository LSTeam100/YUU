//
//  GameYUUListCell.h
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"

@interface GameYUUListCell : YUUBaseTableViewCell

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) UIColor *color;

@end
