//
//  YUUSetingCtrl.h
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface YUUSetingCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *lastLabel;
@property(nonatomic,weak)IBOutlet UIImageView *moreImageView;

@end

@interface YUUSetingCtrl : YUUSuperCtrl<UITableViewDataSource,UITableViewDelegate>

@end
