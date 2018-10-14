//
//  YUUAlertView.m
//  YUU
//
//  Created by apple on 2018/10/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUAlertView.h"

@implementation YUUAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)showYUUAlert:(NSString *)imageName{
    UIImage *img = [UIImage imageNamed:imageName];
    self.alertImageVIew.image= img;    
}

@end
