//
//  YUUPanRestureRecognizer.m
//  YUU
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUPanRestureRecognizer.h"

@implementation YUUPanRestureRecognizer
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.YUUPaneDelegate && [self.YUUPaneDelegate respondsToSelector:@selector(YUUPanRestureTouchEndDelegate:withEvent:)]) {
        [self.YUUPaneDelegate YUUPanRestureTouchEndDelegate:touches withEvent:event];
    }
    
    //    NSLog(@"触摸结束");
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (self.YUUPaneDelegate && [self.YUUPaneDelegate respondsToSelector:@selector(YUUPanRestureTouchEndDelegate:withEvent:)]) {
        [self.YUUPaneDelegate YUUPanRestureTouchEndDelegate:touches withEvent:event];
    }
    //    NSLog(@"取消");
}
@end
