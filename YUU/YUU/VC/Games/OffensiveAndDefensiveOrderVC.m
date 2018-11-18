//
//  OffensiveAndDefensiveOrderVC.m
//  YUU
//
//  Created by boli on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "OffensiveAndDefensiveOrderVC.h"
#import "OffensiveAndDefensiveOrderCell.h"
#import "UIColor+Help.h"
#import "YUUGamesHistroy.h"
#import "GetAttackorderRequest.h"
#import "RankViewController.h"
#import "EnterGameVC.h"

@interface OffensiveAndDefensiveOrderVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *iconNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, assign) BOOL hasNews;

@end

@implementation OffensiveAndDefensiveOrderVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攻守令";
    
    _iconNames = @[@"offensiveAnDefensive0", @"offensiveAnDefensive1", @"offensiveAnDefensive2", @"offensiveAnDefensive3", @"a", @"a"];
//    _titles = @[@"排名与奖励", @"0.3-3YUU", @"3-30YUU", @"30-300YUU", @"历史战报", @"游戏规则"];
    _titles = @[@"进入游戏", @"排名与奖励", @"历史战报", @"游戏规则"];
    _colors = @[[UIColor R:187 G:160 B:100],
                [UIColor R:187 G:160 B:100],
                [UIColor R:187 G:160 B:100],
                [UIColor R:187 G:160 B:100]];
//                [UIColor R:172 G:122 B:90],
//                [UIColor R:182 G:209 B:208],
//                [UIColor R:240 G:59 B:70],
//                [UIColor R:187 G:160 B:100],
//                [UIColor R:187 G:160 B:100],];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self getHTTPData];
}

- (void)getHTTPData {
    [HUD showHUD];
    GetAttackorderRequest *request = [[GetAttackorderRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        if (request.getResponse.data) {
            _hasNews = YES;
        } else {
            _hasNews = NO;
        }
        [self.tableView reloadData];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        [self.tableView reloadData];
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
    
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OffensiveAndDefensiveOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffensiveAndDefensiveOrderCell"];
    
    [cell setColor:_colors[indexPath.section]];
    cell.label.text = _titles[indexPath.section];
    if (indexPath.section == 2 && _hasNews) {
        cell.hasNewRecord = YES;
    } else {
        cell.hasNewRecord = NO;
    }
    cell.icon.image = [UIImage imageNamed:_iconNames[indexPath.section]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EnterGameVC *vc = [EnterGameVC storyboardInstanceType];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        RankViewController *vc = [RankViewController storyboardInstanceType];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 2) {
        YUUGamesHistroy *gameHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"YUUGamesHistroy"];
        [self.navigationController pushViewController:gameHistory animated:YES];
        _hasNews = NO;
        [self.tableView reloadData];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  74;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}



@end
