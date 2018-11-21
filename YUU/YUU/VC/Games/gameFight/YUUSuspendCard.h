//
//  YUUSuspendCard.h
//  YUU
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUUPanRestureRecognizer.h"
@interface YUUSuspendCard : UIWindow<YUUPanRestureRecognizerDelegate>
@property(nonatomic,assign)float cardRadius;


@end
