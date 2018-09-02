//
//  YUUBillCenterCtrl.h
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface YUUBillCenterCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *detailLabel;
@property(nonatomic,weak)IBOutlet UILabel *tailLabel;
@property(nonatomic,weak)IBOutlet UIView *bottomView;
@end


@interface YUUBillCenterCtrl : YUUSuperCtrl

@end
