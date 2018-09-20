//
//  YUUMachineMarketVC.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMachineMarketVC.h"
#import "YUUMachineMarketCell.h"
#import "YUUBaseTableView.h"
#import "UIViewController+Help.h"
#import "AlertController.h"
#import "YUUMilltraderRequest.h"
#import "YUUBuyMachineRequest.h"

@interface YUUMachineMarketVC () <UITableViewDelegate, UITableViewDataSource, YUUMachineMarketCellDelegate>

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableview;

@property (nonatomic, strong) NSArray *items;

@end

@implementation YUUMachineMarketVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMachineMarket" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"机市";
    
    _items = [NSArray array];
    
    WeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getHTTPData];
    }];
    [_tableview.mj_header beginRefreshing];
}

// 获取数据
- (void)getHTTPData {
    WeakSelf
    [HUD showHUD];
    YUUMilltraderRequest *request = [[YUUMilltraderRequest alloc] initWithMilltrader:[YUUUserData shareInstance].token SuccessCallback:^(YUUBaseRequest *request)
    {
        [HUD hide];
        weakSelf.items = request.getResponse.data;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failureCallback:^(YUUBaseRequest *request) {
        [HUD hide];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
    [request start];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUUMachineMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMachineMarketCell"];
    cell.delegate = self;
    cell.model = _items[indexPath.section];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _items.count;
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}

#pragma mark - YUUMachineMarketCellDelegate -
- (void)buyMachine:(YUUMilltraderModel *)model {
    [AlertController alertTitle:@"确认购买" message:nil determine:@"购买" cancel:@"取消" determineHandler:^{
        [HUD showHUD];
        YUUBuyMachineRequest *request = [[YUUBuyMachineRequest alloc] initWithBuyMachine:[YUUUserData shareInstance].token Milltype:[NSNumber numberWithInteger:model.milltype] SuccessCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        } failureCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
}

@end
