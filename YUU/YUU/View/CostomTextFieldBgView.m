//
//  CostomTextFieldBgView.m
//  YUU
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CostomTextFieldBgView.h"

@implementation CostomTextFieldBgView

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = colorWithHexString(@"e4c177",0.15);
    CGFloat radius = (self.frame.size.height / 2) - 7;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [colorWithHexString(@"e4c177",1) CGColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
