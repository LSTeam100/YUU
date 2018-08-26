//
//  YUUSellerInfo.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSellerInfoView.h"

@implementation YUUSellerInfoView

+ (instancetype)xibInstancetype {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

- (instancetype)init {
    if (self = [super init]) {
        _textFields = @[_textField0, _textField1, _textField2, _textField3, _textField4, _textField5, _textField6,];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(300, 260);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _textFields = @[_textField0, _textField1, _textField2, _textField3, _textField4, _textField5, _textField6,];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)copyAction:(UIButton *)sender {
    UILabel *label = _textFields[sender.tag];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = label.text;
}

- (IBAction)closeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(closeBtnDidSelected)]) {
        [_delegate closeBtnDidSelected];
    }
}


@end

@implementation sellerInfoBtn

@end


