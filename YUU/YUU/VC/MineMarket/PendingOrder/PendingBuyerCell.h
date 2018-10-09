//
//  PendingTableViewCell.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "YUUBorderButton.h"
#import "YUUPendingBuyerModel.h"

@protocol PendingBuyerCellDelegate <NSObject>

- (void)buyerCellStatusChanged;

@end

@interface PendingBuyerCell : YUUBaseTableViewCell

@property (nonatomic, weak) id <PendingBuyerCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet YUUBorderButton *middleBtn;

//@property (strong, nonatomic) IBOutlet YUUBorderButton *leftBtn;
//
//@property (strong, nonatomic) IBOutlet YUUBorderButton *rightBtn;

@property (nonatomic, strong) YUUPendingBuyerModel *model;
@property (strong, nonatomic) IBOutlet UIView *bgView;


@end
