//
//  YUUMineMarketPriceCell.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketPriceCell.h"
#import "Header.h"

@implementation YUUMineMarketPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [_priceView removeFromSuperview];
    [self drawPrice];
}

- (void)drawPrice {
    _priceView = [[DrawView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_priceView];
    _priceView.backgroundColor = [UIColor clearColor];
    
    _priceView.lineColor = YUUYellow;
    _priceView.textColor = YUUYellow;
    _priceView.strokeColor = YUUYellow;
    _priceView.fillColor = [UIColor hex:@"#e4c177" alpha:0.3];
    
    _priceView.leftTitles = @[@"0",@"2",@"4",@"6",@"8",@"10", @"12", @"14"];
    _priceView.left = 40;
    _priceView.right = 50;
    _priceView.bottom = 60;
    _priceView.top = 40;
    
    //    _priceView.partLine = 3;
    
    _priceView.maxLeft = 14;
    _priceView.numbers = _priceArr;
    
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView).mas_offset(20);
        make.bottom.mas_equalTo(self.contentView).mas_offset(20);
        make.height.mas_equalTo(280);
    }];
}

- (void)setPriceArr:(NSArray *)priceArr {
    _priceArr = priceArr;
    
}

@end
