//
//  YUUMinePoolVC.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMinePoolVC.h"
#import "YUUMinePoolCell.h"
#import "SHSegmentView.h"
#import "Header.h"

@interface YUUMinePoolVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *powerLabel;
@property (strong, nonatomic) IBOutlet UILabel *minerCountLabel;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation YUUMinePoolVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMinePool" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"矿池";
    _items = [NSMutableArray array];
    
    [self addSegment];
    
    for (int i = 0; i<10; i++) {
        YUUUserModel *model = [[YUUUserModel alloc] init];
        model.userId = @"123456";
        model.uerLevel = YUUUserLevelNew;
        model.power = 13;
        model.machineCount =4;
        model.directPush = 3;
        model.groupNumberCount = 5;
        [_items addObject:model];
    }
    
}

- (void)addSegment {
    WeakSelf
    SHSegmentView *segment = [[SHSegmentView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(weakSelf.powerLabel.mas_bottom).mas_offset(30);
        make.width.mas_equalTo(263);
        make.height.mas_equalTo(38);
    }];
    
    [segment setTitles:@[@"直推" ,@"团队"] segmentSelectedAtIndex:^(NSInteger index) {
        
    }];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUUMinePoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMinePoolCell"];
    cell.model = _items[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _items.count;
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 7)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}

@end
