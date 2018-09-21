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
    return CGSizeMake(300, 140);
}

- (IBAction)closeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(closeBtnDidSelected)]) {
        [_delegate closeBtnDidSelected];
    }
}

- (void)setModel:(MineralPoolModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    
    _label0.text = [NSString stringWithFormat:@"总直推数：%ld", (long)model.totaldirect];
    _label1.text = [NSString stringWithFormat:@"四级矿工数：%ld", (long)model.fourminer];
    _label2.text = [NSString stringWithFormat:@"四级矿工数：%ld", (long)model.threeminer];
    _label3.text = [NSString stringWithFormat:@"四级矿工数：%ld", (long)model.twominer];
    _label4.text = [NSString stringWithFormat:@"四级矿工数：%ld", (long)model.oneminer];
    _label5.text = [NSString stringWithFormat:@"在产矿工数：%ld", (long)model.actminer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
