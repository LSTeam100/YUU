//
//  YUUBaseTableView.m
//  YUU
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableView.h"

@implementation YUUBaseTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
