//
//  DefensiveListCell.h
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "DefensiveListModel.h"
@class DefensiveListCell;

@protocol DefensiveListCellDelegate <NSObject>

- (void)challengeSelected:(DefensiveListCell *)cell;

@end

@interface DefensiveListCell : YUUBaseTableViewCell

@property (nonatomic, weak) id <DefensiveListCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;

@property (nonatomic, strong) DefensiveListModel *model;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end
