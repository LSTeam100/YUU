//
//  RankVC.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RankVC.h"
#import "UIColor+Help.h"
#import "GetOrderweekrankingRequest.h"
#import "RankModel.h"
#import "GetAllRankRequest.h"

@interface RankVC ()
@property (nonatomic, assign) NSInteger currentWeekRank;
@property (nonatomic, assign) NSInteger allRank;
@property (nonatomic, copy) NSString *currentWeekTime;
@property (nonatomic, strong) NSArray *currentWeekItems;
@end

@implementation RankVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _upView.backgroundColor = [UIColor clearColor];
    _upView.layer.masksToBounds = YES;
    _upView.layer.cornerRadius = 8;
    _upView.layer.borderColor = YUUBolderColor.CGColor;
    _upView.layer.borderWidth = 1;
    _upTitle.textColor = YUUBolderColor;
    
    _middleView.backgroundColor = YUUBolderColor;
    
    _weekBtn.layer.cornerRadius = 4;
    _weekBtn.layer.borderColor = YUUBolderColor.CGColor;
    _weekBtn.layer.borderWidth = 1;
    [_weekBtn setTitleColor:YUUBolderColor forState:UIControlStateNormal];
    
    _allBtn.layer.cornerRadius = 4;
    _allBtn.layer.borderColor = YUUBolderColor.CGColor;
    _allBtn.layer.borderWidth = 1;
    [_allBtn setTitleColor:YUUBolderColor forState:UIControlStateNormal];
    
    [_lastWeekBtn setTitleColor:YUUBolderColor forState:UIControlStateNormal];
    
    _rankType = week;
    [self getWeekData];
}


- (void)getWeekData {
    [HUD showHUD];
    GetOrderweekrankingRequest *request = [[GetOrderweekrankingRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        NSDictionary *dict = request.getResponse.data;
        _currentWeekRank = [[dict objectForKey:@"weekranking"] integerValue];
        _currentWeekTime = [dict objectForKey:@"weekendtime"];
        _currentWeekItems = [RankModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"msgList"]];
        [self.tableVeiw reloadData];
        _upTitle.text = @"周排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您本周总获得第%ld位",_currentWeekRank];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        _currentWeekItems = @[];
        [self.tableVeiw reloadData];
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
}

- (void)getAllRankData {
    [HUD showHUD];
    GetAllRankRequest *request = [[GetAllRankRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        NSDictionary *dict = request.getResponse.data;
        _allRank = [[dict objectForKey:@"ordertotalranking"] integerValue];
        _currentWeekItems = [RankModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"msgList"]];
        [self.tableVeiw reloadData];
        _upTitle.text = @"总排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您目前总获得第%ld位",_allRank];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        _currentWeekItems = @[];
        [self.tableVeiw reloadData];
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentWeekItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell"];
    cell.model = _currentWeekItems[indexPath.row];
    if (_rankType == week) {
        cell.label1.text = _currentWeekTime;
    } else {
        cell.label1.text = @"";
    }
    cell.index = indexPath.row;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  54;
}




- (IBAction)weekBtnAction:(id)sender {
    if (_rankType != week) {
        _rankType = week;
        _lastWeekBtn.hidden = NO;
        _middleLabel2.hidden = NO;
        _middleLabel3.text = @"预计获得YUU";
        _middleLabel4.text = @"获得周积分";
//        _upTitle.text = @"周排行榜";
//        _upContentLabel.text = [NSString stringWithFormat:@"您本周总获得第%ld位",_currentWeekRank];
    }
    [self getWeekData];
}

- (IBAction)allBtnAction:(id)sender {
    if (_rankType != all) {
        _rankType = all;
        _lastWeekBtn.hidden = YES;
        _middleLabel2.hidden = YES;
        _middleLabel3.text = @"已获得YUU";
        _middleLabel4.text = @"获得总积分";
//        _upTitle.text = @"总排行榜";
//        _upContentLabel.text = [NSString stringWithFormat:@"您目前总获得第%ld位",_allRank];
    }
    [self getAllRankData];
}

- (IBAction)lastWeekBtnAction:(id)sender {
    if (_showLastRankBlock) {
        _showLastRankBlock();
    }
}



@end
