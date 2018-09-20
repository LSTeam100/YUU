//
//  YUUBaseViewController.h
//  YUU
//
//  Created by boli on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUUBaseTableView.h"
#import "YUUUserData.h"
#import <MJRefresh/MJRefresh.h>
#import "Header.h"

@interface YUUBaseViewController : UIViewController

+ (instancetype)storyboardInstanceType;

- (void)setCustomBackItem;

@end
