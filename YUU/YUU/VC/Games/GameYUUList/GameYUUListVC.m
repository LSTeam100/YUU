//
//  GameYUUListVC.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameYUUListVC.h"
#import "GameYUUListCell.h"

@interface GameYUUListVC ()

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation GameYUUListVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [NSMutableArray array];
    if (_YUU == 0) {
        for (int i = 6; i<30; i++) {
            [_items addObject:[NSNumber numberWithInteger:i]];
            i = i+3;
        }
        self.title = @"0.3-3YUU";
    } else if (_YUU == 1) {
        for (int i = 6; i<30; i++) {
            [_items addObject:[NSNumber numberWithInteger:i]];
            i = i+3;
        }
        self.title = @"6-30YUU";
    } else {
        for (int i = 60; i<300; i++) {
            [_items addObject:[NSNumber numberWithInteger:i]];
            i = i+30;
        }
        self.title = @"60-300YUU";
    }
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameYUUListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameYUUListCell"];
    if (_YUU == 0) {
        cell.color = [UIColor R:172 G:122 B:90];
        cell.icon.image = [UIImage imageNamed:@"YUU0"];
        cell.label.text = [NSString stringWithFormat:@"%@YUU",_items[indexPath.row]];
    } else if (_YUU == 1) {
        cell.color = [UIColor R:182 G:209 B:208];
        cell.icon.image = [UIImage imageNamed:@"YUU1"];
        cell.label.text = [NSString stringWithFormat:@"%@YUU",_items[indexPath.row]];
    } else {
        cell.color = [UIColor R:240 G:59 B:70];
        cell.icon.image = [UIImage imageNamed:@"YUU2"];
        cell.label.text = [NSString stringWithFormat:@"%@YUU",_items[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
