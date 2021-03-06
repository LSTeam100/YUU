//
//  YUUMineMarketPointCell.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"

@protocol YUUMineMarketPointCellDelegate <NSObject>

- (void)selectNotice;

@end

@interface YUUMineMarketPointCell : YUUBaseTableViewCell

@property (nonatomic, weak) id <YUUMineMarketPointCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *idTextField;
@property (strong, nonatomic) IBOutlet UITextField *countTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *noticeBtn;


@end
