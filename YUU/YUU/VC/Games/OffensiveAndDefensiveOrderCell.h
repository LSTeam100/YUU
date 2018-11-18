//
//  OffensiveAndDefensiveOrderCell.h
//  YUU
//
//  Created by boli on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"

@interface OffensiveAndDefensiveOrderCell : YUUBaseTableViewCell


@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) IBOutlet UIView *hasNewRecordIcon;
@property (strong, nonatomic) IBOutlet UILabel *hasNewRecordLabel;

@property (nonatomic, assign) BOOL hasNewRecord;

- (void)setColor:(UIColor *)color;

@end
