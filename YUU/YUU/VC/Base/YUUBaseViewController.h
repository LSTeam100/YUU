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

//@property (nonatomic, assign) BOOL isViewDidLoad;

+ (instancetype)storyboardInstanceType;

- (void)setCustomBackItem;

- (void)getHTTPData;

-(BOOL)handleResponseError:(YUUBaseViewController *)currentController
                   request:(YUUBaseRequest *)request
                 needToken:(BOOL) token;

@end
