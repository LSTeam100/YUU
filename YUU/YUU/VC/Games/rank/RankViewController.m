//
//  RankViewController.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RankViewController.h"
#import "RankVC.h"
#import "LastRankVC.h"

@interface RankViewController ()
@property (nonatomic, strong) RankVC *rankVC;
@property (nonatomic, strong) LastRankVC *lastRankVC;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showRankVC];
}

- (void)showRankVC {
    WeakSelf
    if (!_rankVC) {
        _rankVC = [RankVC storyboardInstanceType];
        [self.view addSubview:_rankVC.view];
        _rankVC.showLastRankBlock = ^(){
            [weakSelf showLastRankVC];
        };
    }
    _rankVC.view.hidden = NO;
    if (_lastRankVC) {
        _lastRankVC.view.hidden = YES;
    }
}

- (void)showLastRankVC {
    WeakSelf
    if (!_lastRankVC) {
        _lastRankVC = [LastRankVC storyboardInstanceType];
        [self.view addSubview:_lastRankVC.view];
        _lastRankVC.showCurrentRankBlock = ^(){
            [weakSelf showRankVC];
        };
    }
    _lastRankVC.view.hidden = NO;
    if (_rankVC) {
        _rankVC.view.hidden = YES;
    }
}



@end
