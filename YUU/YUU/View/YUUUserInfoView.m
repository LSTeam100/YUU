//
//  YUUUserInfoView.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUUserInfoView.h"

@implementation YUUUserInfoView

+ (instancetype)xibInstancetype {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)intrinsicContentSize {
    return CGSizeMake(300, 160);
}

- (IBAction)btn0Action:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _textField0.text;
}
- (IBAction)btn1Action:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _textField1.text;
}

- (IBAction)closeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(closeBtnDidSelected)]) {
        [_delegate closeBtnDidSelected];
    }
}


@end
