//
//  HUDView.m
//  YUU
//
//  Created by boli on 2018/8/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HUDView.h"
#import <Masonry/Masonry.h>

@implementation HUDView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    _bgView = [[UIView alloc] init];
    [self addSubview:_bgView];
    [self sendSubviewToBack:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    _bgView.backgroundColor = YUUYellow_alpha(0.9);
    _bgView.alpha = 0.7;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
