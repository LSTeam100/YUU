//
//  YUUMineMarketVC.m
//  YUU
//
//  Created by boli on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketVC.h"
#import "SHSegmentView.h"
#import "Header.h"
#import "YUUButton.h"
#import "YUUPendingOrderVC.h"
#import "YUUMineMarketMailCell.h"
#import "YUUMineMarketPointCell.h"
#import "YUUMineMarketPriceCell.h"

@interface YUUMineMarketVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn0;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn1;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn2;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn3;

@property (nonatomic, assign) NSInteger segmentSelected;
@property (nonatomic, strong) NSArray *transactionList;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@end

@implementation YUUMineMarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegment];
    [self setButtonStyle];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    
    YUUTransactionModel *model = [[YUUTransactionModel alloc] init];
    model.number = @"626478923";
    model.time = @"1/3 9:00";
    model.content = @"9868387699ffnifnf jdn;nafje njnsllb";
    _transactionList = @[model];
}

- (void)addSegment {
    SHSegmentView *segment = [[SHSegmentView alloc] init];
    [self.view addSubview:segment];
    WeakSelf
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(263);
        make.height.mas_equalTo(38);
    }];
    
    [segment setSegmentTitles:@[@"价格", @"点对点", @"信箱"] segmentSelectedAtIndex:^(NSInteger index) {
        weakSelf.segmentSelected = index;
        [self.tableView reloadData];
    }];
}

- (void)setButtonStyle {
    [_pendingOrderBtn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn0.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn3.titleLabel.font = [UIFont systemFontOfSize:15];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_segmentSelected == 2) {
        return _transactionList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentSelected == 0) {
        YUUMineMarketPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketPriceCell"];
        
        return cell;
    } else if (_segmentSelected == 1) {
        YUUMineMarketPointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketPointCell"];
        
        return cell;
    } else {
        YUUMineMarketMailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketMailCell"];
        cell.model = _transactionList[indexPath.row];
        
        return cell;
    }
}



#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_segmentSelected == 2 && section != 0) {
        return 5;
    }
    return 0;
}



- (IBAction)pendingOrderBtnAction:(UIButton *)sender {
    YUUPendingOrderVC *vc = [YUUPendingOrderVC storyboardInstanceType];
    if (sender.tag == 0) {
        vc.title = @"新手挂单";
    } else if (sender.tag == 1) {
        vc.title = @"";
    } else if (sender.tag == 2) {
        vc.title = @"";
    } else {
        vc.title = @"";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
