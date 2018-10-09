//
//  PendingMailboxCell.h
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "YUUBorderButton.h"
#import "YUUPendingMailboxModel.h"
#import "YUUSellerInfoView.h"

@protocol PendingMailboxCellDelegate <NSObject>

- (void)mailCellStatusChanged;

@end

@interface PendingMailboxCell : YUUBaseTableViewCell <HUDProtocol>

@property (nonatomic, weak) id <PendingMailboxCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet YUUBorderButton *middleBtn;

@property (strong, nonatomic) IBOutlet YUUBorderButton *leftBtn;

@property (strong, nonatomic) IBOutlet YUUBorderButton *rightBtn;

@property (nonatomic, strong) YUUPendingMailboxModel *model;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
