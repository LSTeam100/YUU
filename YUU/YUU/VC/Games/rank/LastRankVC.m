//
//  LastRankVC.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LastRankVC.h"
#import "RankCell.h"
#import "GetLastRankRequest.h"
#import "RankModel.h"

@interface LastRankVC ()
@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *upView;
@property (strong, nonatomic) IBOutlet UILabel *upTitle;
@property (strong, nonatomic) IBOutlet UILabel *upContentLabel;
@property (strong, nonatomic) IBOutlet UIButton *currentWeekBtn;
@property (strong, nonatomic) IBOutlet UIView *middleView;

@property (nonatomic, assign) NSInteger currentWeekRank;
@property (nonatomic, copy) NSString *currentWeekTime;
@property (nonatomic, strong) NSArray *items;

@end

@implementation LastRankVC

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
    
    _middleView.backgroundColor = [UIColor R:15 G:82 B:108];
    
    [_currentWeekBtn setTitleColor:YUUBolderColor forState:UIControlStateNormal];
    
    [self getWeekData];
}

- (void)getWeekData {
    [HUD showHUD];
    GetLastRankRequest *request = [[GetLastRankRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        NSDictionary *dict = request.getResponse.data;
        _currentWeekRank = [[dict objectForKey:@"weekranking"] integerValue];
        _currentWeekTime = [dict objectForKey:@"weekendtime"];
        _items = [RankModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"msgList"]];
        [self.tableView reloadData];
//        _upTitle.text = @"周排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您上周获得第%ld位",_currentWeekRank];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        _items = @[];
        [self.tableView reloadData];
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
//        _upTitle.text = @"周排行榜";
        _upContentLabel.text = [NSString stringWithFormat:@"您上周获得第n位"];
    }];
    [request start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentWeekBtnAction:(id)sender {
    if (_showCurrentRankBlock) {
        _showCurrentRankBlock();
    }
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell"];
    cell.model = _items[indexPath.row];
    cell.index = indexPath.row;
    cell.label1.text = _currentWeekTime;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

@end
