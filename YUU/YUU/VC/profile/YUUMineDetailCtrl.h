//
//  YUUMineDetailCtrl.h
//  YUU
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface profileAuthenCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *detailLabel;
@property(nonatomic,weak)IBOutlet UIButton *authenBtn;
@property(nonatomic,weak)IBOutlet UIImageView *moreImageView;

@end


@interface YUUMineDetailCtrl : YUUSuperCtrl

@end
