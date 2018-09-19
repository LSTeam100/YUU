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
    
    YUUMilltraderModel *model = [[YUUMilltraderModel alloc] init];
//    YUUMachineModel *model = [[YUUMachineModel alloc] init];
//    model.icon = @"miningMachine0";
//    model.name = @"新手云矿机";
    model.compower = @6;
    model.totaldays = @500;
    model.totalcoins = @188.9;
    model.millprice = @120;
    _items = @[model];
    
    [self getHTTPData];
}

// 获取数据
- (void)getHTTPData {
    WeakSelf
    YUUMilltraderRequest *request = [[YUUMilltraderRequest alloc] initWithMilltrader:[YUUUserData shareInstance].userModel.token SuccessCallback:^(YUUBaseRequest *request)
    {
        weakSelf.items = request.getResponse.data;
    } failureCallback:^(YUUBaseRequest *request) {
        NSLog(@"");
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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}

#pragma mark - YUUMachineMarketCellDelegate -
- (void)buyMachine:(YUUMilltraderModel *)model {
    [HUD showHUD];
    [AlertController alertTitle:@"确认购买" message:nil determine:@"购买" cancel:@"取消" determineHandler:^{
        YUUBuyMachineRequest *request = [[YUUBuyMachineRequest alloc] initWithBuyMachine:@"" Milltype:[NSNumber numberWithInteger:model.milltype] SuccessCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        } failureCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
}

@end
