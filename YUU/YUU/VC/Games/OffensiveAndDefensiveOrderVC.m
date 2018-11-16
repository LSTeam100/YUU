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
@interface OffensiveAndDefensiveOrderVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *iconNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation OffensiveAndDefensiveOrderVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攻守令";
    
    _iconNames = @[@"a", @"a", @"a", @"a", @"a", @"a"];
    _titles = @[@"排名与奖励", @"0.3-3YUU", @"3-30YUU", @"30-300YUU", @"历史战报", @"游戏规则"];
    _colors = @[[UIColor R:187 G:160 B:100],
                [UIColor R:172 G:122 B:90],
                [UIColor R:182 G:209 B:208],
                [UIColor R:240 G:59 B:70],
                [UIColor R:187 G:160 B:100],
                [UIColor R:187 G:160 B:100],];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OffensiveAndDefensiveOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffensiveAndDefensiveOrderCell"];
    
    [cell setColor:_colors[indexPath.section]];
    cell.label.text = _titles[indexPath.section];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:_iconNames[indexPath.section]];
    cell.icon.image = [UIImage imageWithContentsOfFile:filePath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        YUUGamesHistroy *gameHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"YUUGamesHistroy"];
        [self.navigationController pushViewController:gameHistory animated:YES];
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
