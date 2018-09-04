//
//  YUUTransactionHistoryCtrl.h
//  YUU
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface transactionHistoryCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *contentLabel;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;
@property(nonatomic,weak)IBOutlet UIView *bottomView;
@end

@interface YUUTransactionHistoryCtrl : YUUSuperCtrl

@end
