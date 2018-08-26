//
//  YUUTeamInfo.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUTeamInfoView.h"

@implementation YUUTeamInfoView

+ (instancetype)xibInstancetype {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(300, 260);
}

- (IBAction)closeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(closeBtnDidSelected)]) {
        [_delegate closeBtnDidSelected];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
