//
//  YUUMineMarketPriceCell.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "DrawView.h"

@interface YUUMineMarketPriceCell : YUUBaseTableViewCell

@property (nonatomic, strong) DrawView *priceView;

@property (nonatomic, strong) NSArray *priceArr;

@end
