//
//  YUUMachineMarketCell.h
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUUMachineModel.h"
#import "YUUBaseTableViewCell.h"

@protocol YUUMachineMarketCellDelegate <NSObject>

- (void)buyMachine:(YUUMachineModel *)model;

@end

@interface YUUMachineMarketCell : YUUBaseTableViewCell

@property (nonatomic, weak) id <YUUMachineMarketCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *ComputingPowerLabel;

@property (strong, nonatomic) IBOutlet UILabel *cycleLabel;

@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;

@property (strong, nonatomic) IBOutlet UIButton *buyBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UIView *upLine;
@property (strong, nonatomic) IBOutlet UIView *downLine;

@property (nonatomic, strong) YUUMachineModel *model;




@end
