//
//  DefensiveListVC.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "DefensiveListVC.h"
#import "DefensiveListCell.h"
#import "GetAttackListRequest.h"

@interface DefensiveListVC ()

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *upView;
@property (strong, nonatomic) IBOutlet UIView *middleView;


@property (nonatomic, strong) NSArray *items;

@end

@implementation DefensiveListVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攻守令";
    
    _upView.backgroundColor = [UIColor clearColor];
    _upView.layer.masksToBounds = YES;
    _upView.layer.cornerRadius = 8;
    _upView.layer.borderColor = YUUBolderColor.CGColor;
    _upView.layer.borderWidth = 1;
    
    
    _middleView.backgroundColor = [UIColor R:15 G:82 B:108];
    
    [self getHTTPData];
}

- (void)getHTTPData {
    [HUD showHUD];
    GetAttackListRequest *request = [[GetAttackListRequest alloc] initWarzone:[NSString stringWithFormat:@"%ld",_YUU] success:^(YUUBaseRequest *request) {
        _items = request.getResponse.data;
        [_tableView reloadData];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        _items = @[];
        [self.tableView reloadData];
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DefensiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefensiveListCell"];

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

@end
