//
//  YUUMineMarketMailCell.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "YUUPendingMailboxModel.h"
#import "YUUSellerOnsaleRequest.h"

@interface YUUMineMarketMailCell : YUUBaseTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIButton *middleBtn;
@property (strong, nonatomic) IBOutlet UIButton *middleRightBtn;
@property (strong, nonatomic) IBOutlet UIButton *middleLeftBtn;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) YUUPendingMailboxModel *model;



@end
