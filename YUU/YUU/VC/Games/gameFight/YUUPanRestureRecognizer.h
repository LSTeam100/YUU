//
//  YUUPanRestureRecognizer.h
//  YUU
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>


@protocol YUUPanRestureRecognizerDelegate <NSObject>

-(void)YUUPanRestureTouchEndDelegate:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface YUUPanRestureRecognizer : UIPanGestureRecognizer
@property(nonatomic,weak)id YUUPaneDelegate;

@end
