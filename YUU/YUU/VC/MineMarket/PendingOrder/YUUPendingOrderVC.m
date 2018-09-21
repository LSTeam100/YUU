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
    
    _upLabel.textColor = [UIColor R:255.0 G:255.0 B:255.0];
    _upLabel.backgroundColor = [UIColor hex:@"e4c177" alpha:0.1];
    _upLabel.layer.borderColor = YUUYellow.CGColor;
    _upLabel.layer.borderWidth = 1;
    NSString *str = @"";
    if (_level == 0) {
        str = @"1-50";
    } else if (_level == 1) {
        str = @"50-100";
    } else if (_level == 1) {
        str = @"100-500";
    } else if (_level == 1) {
        str = @"500-1000";
    }
    _upLabel.text = [NSString stringWithFormat:@"认证用户可进行%@YUU议价交易",str];
    

    
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
    
    
    {
        YUUPendingBuyerModel *model = [[YUUPendingBuyerModel alloc] init];
        model.tradingcard = @"828722626";
        model.tradingtime = @"2018";
        model.memberid = 1111;
        model.coinnum = 23;
        model.buyprice = 100;
        _buyerArr = @[model, model];
    }
    
    {
        YUUPendingMailboxModel *model = [[YUUPendingMailboxModel alloc] init];
        model.sorbid = 1111;
        model.tradingtime = @"2018";
        model.tradingcard = @"90000";
        model.membername = @"小明";
        model.bankname = @"工商";
        model.bankcard = @"6225 6225 6225";
        model.memberwx = @"wechat";
        model.memberalipay = @"alibaba";
        model.memberphone = @"1390000000";
        model.memberwallet = @"2222";
        model.sellorbuy = 1;
        model.progressnum = 2;

        YUUPendingMailboxModel *model0 = [[YUUPendingMailboxModel alloc] init];
        model0.sorbid = 1111;
        model0.tradingtime = @"2018";
        model0.tradingcard = @"90000";
        model0.membername = @"小明";
        model0.bankname = @"工商";
        model0.bankcard = @"6225 6225 6225";
        model0.memberwx = @"wechat";
        model0.memberalipay = @"alibaba";
        model0.memberphone = @"1390000000";
        model0.memberwallet = @"2222";
        model0.sellorbuy = 0;
        model0.progressnum = 1;
        
        _mailArr = @[model, model0];
    }
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
//        if (request.getResponse.code == 4) {
//            weakSelf.buyerArr = @[];
//            [weakSelf.tableView reloadData];
//        }
        [weakSelf.tableView reloadData];
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
//        if (request.getResponse.code == 4) {
//            weakSelf.mailArr = @[];
//            [weakSelf.tableView reloadData];
//        }
        [weakSelf.tableView reloadData];
        [HUD showRequest:request];
    }];
    [request start];
}

- (IBAction)hangingOrderAction:(UIButton *)sender {
    YUUPointOnsaleRequest *request = [[YUUPointOnsaleRequest alloc] initWithSellerTransaction:[YUUUserData shareInstance].token Uporderstype:[NSString stringWithFormat:@"%ld",_level] Buynum:_countTextField.text Buyprice:_myPrice.text SuccessCallback:^(YUUBaseRequest *request) {
        
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
        PendingBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingBuyerCell"];
        cell.model = _buyerArr[indexPath.section];
        return cell;
    } else {
        PendingMailboxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingMailboxCell"];
        cell.model = _mailArr[indexPath.section];
        return cell;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_segmentSelected == 0) {
        return _buyerArr.count;
    }
    return _mailArr.count;
}

#pragma mark - UITableViewDelegate -
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  84;
//}

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
