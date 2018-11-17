//
//  LastRankVC.h
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseViewController.h"

typedef void(^ShowCurrentRankBlock)();

@interface LastRankVC : YUUBaseViewController

@property (nonatomic, strong) ShowCurrentRankBlock showCurrentRankBlock;

@end
