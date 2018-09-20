//
//  YUUPendingOrderVC.m
//  YUU
//
//  Created by boli on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingOrderVC.h"
#import "SHSegmentView.h"
#import "PendingBuyerCell.h"
#import "PendingMailboxCell.h"
#import "YUUGetPendingMailRequest.h"
#import "YUUGetPendingOrderBuyerRequest.h"
#import "YUUPendingBuyerModel.h"
#import "YUUGetPendingMailRequest.h"
#import "YUUPendingMailboxModel.h"
#import "YUUPointOnsaleRequest.h"

@interface YUUPendingOrderVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SHSegmentView *segmentView;
@property (nonatomic, assign) NSInteger segmentSelected;
@property (nonatomic, strong) NSArray *buyerArr;
@property (nonatomic, strong) NSArray *mailArr;

@property (nonatomic, assign) double currentPrice;

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
        weakSelf.segmentSelected = index;
    }];
    
    [self getBuyerInfo];
    _slider.maximumValue = _sliderEnd;
    _slider.minimumValue = _sliderBegin;
    _slider.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    
    _countTextField.textColor = YUUYellow;
    _countTextField.layer.masksToBounds = YES;
    _countTextField.layer.cornerRadius = 5;
    _countTextField.layer.borderColor = [YUUYellow CGColor];
    _countTextField.layer.borderWidth = 1;
    _countTextField.backgroundColor = [UIColor hex:@"#e4c177" alpha:0.3];
    
    _currentPriceLabel.text = [NSString stringWithFormat:@"%@",_model.sevenprice];
    self.currentPrice = [_model.sevenprice doubleValue];
}

- (void)sliderChange:(UISlider *)slider {
    _countTextField.text = [NSString stringWithFormat:@"%.0f",slider.value];
}

- (void)getBuyerInfo {
    WeakSelf
    [HUD showHUD];
    YUUGetPendingOrderBuyerRequest *request = [[YUUGetPendingOrderBuyerRequest alloc] initWithUserLevel:_level success:^(YUUBaseRequest *request) {
        weakSelf.buyerArr = request.getResponse.data;
        [weakSelf.tableView reloadData];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        if (request.getResponse.code == 4) {
            weakSelf.buyerArr = @[];
            [weakSelf.tableView reloadData];
        }
        [HUD showRequest:request];
    }];
    [request start];
}

- (void)getMailInfo {
    WeakSelf
    [HUD showHUD];
    YUUGetPendingMailRequest *request = [[YUUGetPendingMailRequest alloc] initWithUserLevel:_level success:^(YUUBaseRequest *request) {
        weakSelf.mailArr = request.getResponse.data;
        [weakSelf.tableView reloadData];
        [HUD showRequest:request];
    } failure:^(YUUBaseRequest *request) {
        if (request.getResponse.code == 4) {
            weakSelf.mailArr = @[];
            [weakSelf.tableView reloadData];
        }
        [HUD showRequest:request];
    }];
    [request start];
}

- (IBAction)hangingOrderAction:(UIButton *)sender {
    YUUPointOnsaleRequest *request = [[YUUPointOnsaleRequest alloc] initWithSellerTransaction:[YUUUserData shareInstance].token Uporderstype:[NSString stringWithFormat:@"%ld",_level] Buynum:@"" Buyprice:@"" SuccessCallback:^(YUUBaseRequest *request) {
        
    } failureCallback:^(YUUBaseRequest *request) {
        
    }];
    [request start];
}


#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentSelected == 0) {
        PendingBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingTableViewCell"];
        
    } else {
        
    }
PendingBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingTableViewCell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_segmentSelected == 0) {
        return _buyerArr.count;
    }
    return _mailArr.count;
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}


- (IBAction)plusAction:(id)sender {
    self.currentPrice -= 1;
}

- (IBAction)lessAction:(id)sender {
    self.currentPrice += 1;
}

- (void)setCurrentPrice:(double)currentPrice {
    if (currentPrice < 0) {
        return;
    }
    _currentPrice = currentPrice;
    _myPrice.text = [NSString stringWithFormat:@"%0.2f",_currentPrice];
}


@end
