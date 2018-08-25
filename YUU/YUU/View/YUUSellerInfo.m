//
//  YUUSellerInfo.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSellerInfo.h"

@implementation YUUSellerInfo

+ (instancetype)xibInstancetype {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

- (instancetype)init {
    if (self = [super init]) {
        _labels = @[_label0, _label1, _label2, _label3, _label4, _label5, _label6,];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _labels = @[_label0, _label1, _label2, _label3, _label4, _label5, _label6,];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)copyAction:(UIButton *)sender {
    UILabel *label = _labels[sender.tag];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = label.text;
}



@end

@implementation sellerInfoBtn

@end

@implementation sellerInfoBg

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
