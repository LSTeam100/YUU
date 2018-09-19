//
//  YUUPendingOrderVC.m
//  YUU
//
//  Created by boli on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingOrderVC.h"
#import "SHSegmentView.h"
#import "PendingTableViewCell.h"
#import "YUUGetPendingMailRequest.h"
#import "YUUGetPendingOrderBuyerRequest.h"
#import "YUUPendingBuyerModel.h"
#import "YUUGetPendingMailRequest.h"
#import "YUUPendingMailboxModel.h"
#import "YUUPointOnsaleRequest.h"

@interface YUUPendingOrderVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) SHSegmentView *segmentView;

@end

@implementation YUUPendingOrderVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMineMarket" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    
    _segmentView = [[SHSegmentView alloc] init];
    [self.view addSubview:_segmentView];
    WeakSelf
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.left.mas_equalTo(weakSelf.view).mas_offset(40);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(weakSelf.tableView.mas_top).mas_offset(-20);
    }];
    
    [_segmentView setSegmentTitles:@[@"买家看板", @"交易信箱"] segmentSelectedAtIndex:^(NSInteger index) {
        if (index == 0) {
            [weakSelf getBuyerInfo];
        } else {
            [weakSelf getMailInfo];
        }
    }];
    
    [self getBuyerInfo];
    _slider.maximumValue = _sliderEnd;
    _slider.minimumValue = _sliderBegin;
    _slider.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderChange:(UISlider *)slider {
    
}

- (void)getBuyerInfo {
    WeakSelf
    YUUGetPendingOrderBuyerRequest *request = [[YUUGetPendingOrderBuyerRequest alloc] initWithUserLevel:_level success:^(YUUBaseRequest *request) {
        weakSelf.items = request.getResponse.data;
        [weakSelf.tableView reloadData];
    } failure:^(YUUBaseRequest *request) {
        
    }];
    [request start];
}

- (void)getMailInfo {
    WeakSelf
    YUUGetPendingMailRequest *request = [[YUUGetPendingMailRequest alloc] initWithUserLevel:_level success:^(YUUBaseRequest *request) {
        weakSelf.items = request.getResponse.data;
        [weakSelf.tableView reloadData];
    } failure:^(YUUBaseRequest *request) {
        
    }];
    [request start];
}

- (IBAction)hangingOrderAction:(UIButton *)sender {
    YUUPointOnsaleRequest *request = [[YUUPointOnsaleRequest alloc] initWithSellerTransaction:@"" Uporderstype:[NSString stringWithFormat:@"%ld",_level] Buynum:@"" Buyprice:@"" SuccessCallback:^(YUUBaseRequest *request) {
        
    } failureCallback:^(YUUBaseRequest *request) {
        
    }];
    [request start];
}


#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PendingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingTableViewCell"];


    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _items.count;
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  84;
}


@end
