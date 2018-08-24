//
//  YUUMessageCtrl.h
//  YUU
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"
@interface YUUMessageCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;
@property(nonatomic,weak)IBOutlet UILabel *detailLabel;


@end

@interface YUUMessageCtrl : YUUSuperCtrl

@end
