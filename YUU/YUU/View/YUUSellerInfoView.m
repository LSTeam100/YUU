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
    return CGSizeMake(300, 420);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _textFields = @[_textField0, _textField1, _textField2, _textField3, _textField4, _textField5, _textField6,];
    
    _backgroundView.backgroundColor = [UIColor hex:@"e4c177" alpha:0.3];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 10;
    
    _label.textColor = [UIColor R:239 G:102 B:7];
    
    
}

- (void)setModel:(YUUPendingMailboxModel *)model {
    _textField0.text = model.membername;
    _textField1.text = model.bankname;
    _textField2.text = model.bankcard;
    _textField3.text = model.memberwx;
    _textField4.text = model.memberalipay;
    _textField5.text = model.memberphone;
    _textField6.text = model.memberwallet;
}


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


