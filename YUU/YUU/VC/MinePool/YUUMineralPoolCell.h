//
//  YUUMineralPoolCell.h
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectPushModel.h"
#import "TeamPushModel.h"
#import "YUUBaseTableViewCell.h"

@interface YUUMineralPoolCell : YUUBaseTableViewCell

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *powerLabel;
@property (strong, nonatomic) IBOutlet UILabel *machineCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *directPushLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamCountLabel;

@property (nonatomic, strong) DirectPushModel *directModel;
@property (nonatomic, strong) TeamPushModel *teamModel;


@end
