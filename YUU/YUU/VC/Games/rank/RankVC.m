//
//  RankVC.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RankVC.h"
#import "UIColor+Help.h"


@interface RankVC ()

@end

@implementation RankVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell"];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  74;
}




- (IBAction)weekBtnAction:(id)sender {
    if (_rankType != week) {
        _rankType = week;
        _lastWeekBtn.hidden = NO;
        _upTitle.text = @"周排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您本周总获得第%ld位"];
    }
}

- (IBAction)allBtnAction:(id)sender {
    if (_rankType != all) {
        _rankType = all;
        _lastWeekBtn.hidden = YES;
        _upTitle.text = @"总排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您目前总获得第%ld位"];
    }
}

- (IBAction)lastWeekBtnAction:(id)sender {
}

@end
