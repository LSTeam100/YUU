//
//  CommLabel.m
//  YUU
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CommLabel.h"

@implementation CommLabel
    
-(void)drawTextInRect:(CGRect)rect{
    CGRect newRect = CGRectMake(rect.origin.x + 5, rect.origin.y + 1.5, rect.size.width - 10, rect.size.height - 3);
    [super drawTextInRect:newRect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
