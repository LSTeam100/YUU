//
//  DrawView.m
//  test
//
//  Created by boli on 2018/8/26.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "DrawView.h"
#import "UIView+Help.h"

#define DrawView_font  [UIFont systemFontOfSize:14]

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _left = 40;
        _top = 20;
        _bottom = 40;
        _right = 20;
        _partLine = 10;
        _maxLeft = 100.0;
        _numbers = @[@20, @80.0, @50.0, @30.0, @50.0];
        
        _lineColor = [UIColor blueColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    // left line
    [self drawLineFromPoint:CGPointMake(_left, 20) toPoint:CGPointMake(_left, self.height - _bottom) color:_lineColor];
    for (int i = 0; i < _leftTitles.count; i ++) {
        NSInteger part = (self.height-_top-_bottom)/(_leftTitles.count-1);
        [self drawLineFromPoint:CGPointMake(_left, _top+(part*i)) toPoint:CGPointMake(_left-_partLine, _top+(part*i)) color:_lineColor];
        // title
        [_leftTitles[i] drawAtPoint:CGPointMake(10, _top+part*i-8) withAttributes:@{NSFontAttributeName : DrawView_font}];
    }
    
    // bottom line
    [self drawLineFromPoint:CGPointMake(_left, self.height-_bottom) toPoint:CGPointMake(self.width-_right, self.height-_bottom) color:_lineColor];
    for (int i = 0; i < _bottomTitles.count; i ++) {
        NSInteger part = (self.width-_left-_right)/(_bottomTitles.count-1);
        NSInteger bottomLineTop = self.height - _bottom;
        [self drawLineFromPoint:CGPointMake(_left+(part*i), bottomLineTop) toPoint:CGPointMake(_left+(part*i), bottomLineTop+_partLine) color:_lineColor];
        
        // title
        [_bottomTitles[i] drawAtPoint:CGPointMake(_left+part*i-10, self.height-_bottom+10) withAttributes:@{NSFontAttributeName : DrawView_font}];
    }
    
    [self drawArea];
    [self drawNumberLineWithColor:_lineColor];
}

- (void)drawArea {
    //创建UIBezierPath
    NSInteger part = (self.width-_left-_right)/(_bottomTitles.count-1);
    NSInteger allPart = self.height-_top-_bottom;
    UIBezierPath *apath = ({
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth     = 5.0f;              //设置线条宽度
        path.lineCapStyle  = kCGLineCapRound;   //设置拐角
        path.lineJoinStyle = kCGLineCapRound;  //终点处理
        //设置起始点
        [path moveToPoint:CGPointMake(_left, self.height-_bottom)];
        
        //增加线条
        for (int i = 0; i < _numbers.count; i ++) {
            double t = [_numbers[i] floatValue];
            CGPoint point = CGPointMake(_left+part*i, _top+((_maxLeft-t)/_maxLeft*allPart));
            [path addLineToPoint:point];
        }
        
        [path addLineToPoint:CGPointMake(_left+part*(_numbers.count-1), self.height-_bottom)];
        
        [[UIColor yellowColor] setStroke];
        [[UIColor redColor] setFill];
        
        //关闭路径
        [path closePath];
        
        path;
    });
    
    //根据坐标连线
    [apath stroke];
    [apath fill];
}

- (void)drawLineFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint color:(UIColor *)color {
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[color CGColor]];
    solidShapeLayer.lineWidth = 2.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, fromPoint.x, fromPoint.y);
    CGPathAddLineToPoint(solidShapePath, NULL, toPoint.x, toPoint.y);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.layer addSublayer:solidShapeLayer];
}

- (void)drawNumberLineWithColor:(UIColor *)color {
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[color CGColor]];
    solidShapeLayer.lineWidth = 2.0f ;
    
    
    NSInteger part = (self.width-_left-_right)/(_bottomTitles.count-1);
    NSInteger allPart = self.height-_top-_bottom;
    for (int i = 0; i < _numbers.count; i ++) {
        double t = [_numbers[i] floatValue];
        CGPoint point = CGPointMake(_left+part*i, _top+((_maxLeft-t)/_maxLeft*allPart));
        
        if (i == 0) {
            CGPathMoveToPoint(solidShapePath, NULL, point.x, point.y);
        } else {
            CGPathAddLineToPoint(solidShapePath, NULL, point.x, point.y);
        }
        
        [self drawCircleAtPoint:point width:10 color:[UIColor greenColor]];
    }
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.layer addSublayer:solidShapeLayer];
}

- (void)drawCircleAtPoint:(CGPoint)point width:(NSInteger)width color:(UIColor *)color{
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 2.0f ;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = color.CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(point.x-width/2, point.y-width/2, width, width));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [self.layer addSublayer:solidLine];
}


@end
