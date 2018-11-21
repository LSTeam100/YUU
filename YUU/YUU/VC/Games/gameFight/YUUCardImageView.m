//
//  YUUCardImageView.m
//  YUU
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUCardImageView.h"
#import <UIKit/UIGestureRecognizer.h>
@implementation YUUCardImageView
{
    CGPoint startLocation;
}


- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
        CGPoint pt = [[touches anyObject] locationInView:self];
        startLocation = pt;
        [[self superview] bringSubviewToFront:self];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self endHandle];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //判断靠边的位置
    [self endHandle];
}
-(void)endHandle{
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    float centerX = screenWidth/2;
    float defaultWhiteradius = self.frame.size.width;
    
    
    if (self.center.x < centerX) {
        if (self.center.y < defaultWhiteradius) {
            CGPoint finalPoint;
            finalPoint.x = self.center.x;
            finalPoint.y = defaultWhiteradius/2;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
        else if (self.center.y > screenHeight - defaultWhiteradius)
        {
            CGPoint finalPoint;
            finalPoint.x = self.center.x;
            finalPoint.y = screenHeight - defaultWhiteradius/2;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
        else
        {
            CGPoint finalPoint;
            finalPoint.x = defaultWhiteradius/2;
            finalPoint.y = self.center.y;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
    }
    else
    {
        if (self.center.y < defaultWhiteradius) {
            CGPoint finalPoint;
            finalPoint.x = self.center.x;
            finalPoint.y = defaultWhiteradius/2;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
        else if (self.center.y > screenHeight - defaultWhiteradius)
        {
            CGPoint finalPoint;
            finalPoint.x = self.center.x;
            finalPoint.y = screenHeight - defaultWhiteradius/2;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
        else
        {
            CGPoint finalPoint;
            finalPoint.x = screenWidth - defaultWhiteradius/2;
            finalPoint.y = self.center.y;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.center = finalPoint;
                             }
                             completion:nil];
        }
    }
}

//- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
//{
//        // Calculate offset
//        CGPoint pt = [[touches anyObject] locationInView:self];
//        float dx = pt.x - startLocation.x;
//        float dy = pt.y - startLocation.y;
//        CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
//
//
//    //设置移动的区域
//
//        // Bound movement into parent bounds
//        float halfx = CGRectGetMidX(self.bounds);
//        newcenter.x = MAX(halfx, newcenter.x);
//        newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
//
//        float halfy = CGRectGetMidY(self.bounds);
//        newcenter.y = MAX(halfy, newcenter.y);
//        newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
//
//        // Set new location
//        self.center = newcenter;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
