//
//  YUUCurrencyTransactionCtrl.h
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface YUUCurrencyCell : UITableViewCell;
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UIView *bottomView;
@property(nonatomic,weak)IBOutlet UITextField *field;
@end

@interface YUUCurrencyTransactionCtrl : YUUSuperCtrl

@end
