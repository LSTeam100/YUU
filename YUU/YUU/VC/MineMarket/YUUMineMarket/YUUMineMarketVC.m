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
#import "YUUMineMarketRequest.h"
#import "YUUMineMarketMailRequest.h"

@interface YUUMineMarketVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn0;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn1;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn2;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn3;

@property (nonatomic, assign) NSInteger segmentSelected;
@property (nonatomic, strong) NSArray *mailList;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) YUUPriceModel *model;
@property (nonatomic, strong) NSArray *priceArr;

@end

@implementation YUUMineMarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"矿市";
    
    [self addSegment];
    [self setButtonStyle];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    
    [self getHTTPData];
}

- (void)getHTTPData {
    WeakSelf
    [HUD showHUD];
    YUUMineMarketRequest *request = [[YUUMineMarketRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        weakSelf.model = request.getResponse.data;
        [weakSelf updateUI];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        NSLog(@"");
        [HUD showRequest:request];
    }];
    [request start];
}

- (void)getMailData {
    WeakSelf
    [HUD showHUD];
    YUUMineMarketMailRequest *request = [[YUUMineMarketMailRequest alloc] initSuccess:^(YUUBaseRequest *request) {
        weakSelf.mailList = request.getResponse.data;
        [weakSelf.tableView reloadData];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        [HUD showRequest:request];
    }];
    [request start];
}

- (void)updateUI {
    _priceLabel.text = [NSString stringWithFormat:@"%@", _model.sevenprice];
    _timeLabel.text = [NSString stringWithFormat:@"次：%ld", _model.tradernum];
    _priceArr = @[_model.oneprice,
                  _model.twoprice,
                  _model.threeprice,
                  _model.fourprice,
                  _model.fiveprice,
                  _model.sixprice,
                  _model.sevenprice];
    [self.tableView reloadData];
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
        if (index == 2) {
            [self getMailData];
        }
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
        return _mailList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentSelected == 0) {
        YUUMineMarketPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketPriceCell"];
        cell.priceArr = _priceArr;
        return cell;
    } else if (_segmentSelected == 1) {
        YUUMineMarketPointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketPointCell"];
        
        return cell;
    } else {
        YUUMineMarketMailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMarketMailCell"];
        cell.model = _mailList[indexPath.row];
        
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
        vc.level = UserLevelNovice;
        vc.sliderBegin = 1;
        vc.sliderEnd = 50;
    } else if (sender.tag == 1) {
        vc.title = @"进阶挂单";
        vc.level = UserLevelAdvanced;
        vc.sliderBegin = 50;
        vc.sliderEnd = 100;
    } else if (sender.tag == 2) {
        vc.title = @"高手挂单";
        vc.level = UserLevelMaster;
        vc.sliderBegin = 100;
        vc.sliderEnd = 500;
    } else {
        vc.title = @"国际挂单";
        vc.level = UserLevelInternational;
        vc.sliderBegin = 500;
        vc.sliderEnd = 1000;
    }
    vc.model = _model;
    self.hidesBottomBarWhenPushed = YES;
    [self setCustomBackItem];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}



@end
