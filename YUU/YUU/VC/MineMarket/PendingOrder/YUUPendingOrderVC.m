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
#import "AlertController.h"
#import "YUUPendingNoticeVC.h"

@interface YUUPendingOrderVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,PendingMailboxCellDelegate, PendingBuyerCellDelegate>

@property (nonatomic, strong) SHSegmentView *segmentView;
@property (nonatomic, assign) NSInteger segmentSelected;
@property (nonatomic, strong) NSArray *buyerArr;
@property (nonatomic, strong) NSArray *mailArr;

@property (nonatomic, assign) double currentPrice;

@property (strong, nonatomic) IBOutlet UILabel *currentPriceTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentPriceUnitLabel;

@property (strong, nonatomic) IBOutlet UILabel *internetCurrentPriceLabel;


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
    
    _currentPriceLabel.text = [NSString stringWithFormat:@"%@",_model.sevenprice];

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
    
    
    _countTextField.textColor = YUUYellow;
    _countTextField.layer.masksToBounds = YES;
    _countTextField.layer.cornerRadius = 5;
    _countTextField.layer.borderColor = [YUUYellow CGColor];
    _countTextField.layer.borderWidth = 1;
    _countTextField.backgroundColor = [UIColor hex:@"#e4c177" alpha:0.3];
    [_countTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.currentPrice = [_model.sevenprice doubleValue];
    if (_level == UserLevelNovice) {
        _upLabel.text = @"认证用户可进行1-50YUU议价交易!";
        _countTextField.text = @"1";
        _sliderBegin = 1;
        _sliderEnd = 50;
        _currentPriceTitleLabel.hidden = NO;
        _currentPriceLabel.hidden = NO;
        _currentPriceUnitLabel.hidden = NO;
        _internetCurrentPriceLabel.hidden = YES;
    } else if (_level == UserLevelAdvanced) {
        _upLabel.text = @"算力≥10用户可进行51-500YUU议价交易!";
        _countTextField.text = @"51";
        _sliderBegin = 51;
        _sliderEnd = 500;
        _currentPriceTitleLabel.hidden = NO;
        _currentPriceLabel.hidden = NO;
        _currentPriceUnitLabel.hidden = NO;
        _internetCurrentPriceLabel.hidden = YES;
    } else if (_level == UserLevelMaster) {
        _upLabel.text = @"算力≥100用户可进行501-10000YUU议价交易!";
        _countTextField.text = @"501";
        _sliderBegin = 501;
        _sliderEnd = 10000;
        _currentPriceTitleLabel.hidden = NO;
        _currentPriceLabel.hidden = NO;
        _currentPriceUnitLabel.hidden = NO;
        _internetCurrentPriceLabel.hidden = YES;
    } else if (_level == UserLevelInternational) {
        _upLabel.text = @"算力≥100用户可进行501-10000YUU议价交易!";
        _countTextField.text = @"501";
        _sliderBegin = 501;
        _sliderEnd = 10000;
        _myPrice.text = @"0.0001";
        self.currentPrice = 0.0001;
        _currentPriceTitleLabel.hidden = YES;
        _currentPriceLabel.hidden = YES;
        _currentPriceUnitLabel.hidden = YES;
        _internetCurrentPriceLabel.hidden = NO;
    }
    
    
    _slider.maximumValue = _sliderEnd;
    _slider.minimumValue = _sliderBegin;
    _slider.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
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
        [weakSelf.tableView reloadData];
//        [HUD showRequest:request];
        [HUD hide];
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];
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
        [weakSelf.tableView reloadData];
//        [HUD showRequest:request];
        [HUD hide];
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];
    }];
    [request start];
}

- (IBAction)hangingOrderAction:(UIButton *)sender {
    [AlertController alertTitle:@"确认挂买单" message:nil determine:@"确定" cancel:@"取消" determineHandler:^{
        [HUD showHUD];
        WeakSelf
        YUUPointOnsaleRequest *request = [[YUUPointOnsaleRequest alloc] initWithSellerTransaction:[YUUUserData shareInstance].token Uporderstype:[NSString stringWithFormat:@"%ld",_level] Buynum:_countTextField.text Buyprice:_myPrice.text SuccessCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD showHUDTitle:@"挂单成功" durationTime:2];
        } failureCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD hide];
            [weakSelf handleResponseError:weakSelf request:request needToken:YES];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
}


#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentSelected == 0) {
        PendingBuyerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingBuyerCell"];
        cell.model = _buyerArr[indexPath.section];
        cell.delegate = self;
        return cell;
    } else {
        PendingMailboxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingMailboxCell"];
        cell.model = _mailArr[indexPath.section];
        cell.delegate = self;
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
    if (_level == UserLevelInternational) {
        self.currentPrice -= 0.0001;
    } else {
        self.currentPrice -= 1;
    }
}

- (IBAction)lessAction:(id)sender {
    if (_level == UserLevelInternational) {
        self.currentPrice += 0.0001;
    } else {
        self.currentPrice += 1;
    }
}

- (void)setCurrentPrice:(double)currentPrice {
    if (_level == UserLevelInternational) {
        if (currentPrice < 0.0001) {
            return;
        }
    } else {
        if (currentPrice < 0) {
            return;
        }
    }
    
    _currentPrice = currentPrice;
    if (_level == UserLevelInternational) {
        if (currentPrice < 0.0001) {
            currentPrice = 0.0001;
        }
        _myPrice.text = [NSString stringWithFormat:@"%0.4f",_currentPrice];
        _totalPriceLabel.text = [NSString stringWithFormat:@"买入%@YUU，出价%@ETH，总价%0.4fETH",_countTextField.text, _myPrice.text, [_countTextField.text floatValue] * [_myPrice.text floatValue]];
    } else {

        _myPrice.text = [NSString stringWithFormat:@"%0.2f",_currentPrice];
        _totalPriceLabel.text = [NSString stringWithFormat:@"买入%@YUU，出价%@元，总价%0.2f元",_countTextField.text, _myPrice.text, [_countTextField.text floatValue] * [_myPrice.text floatValue]];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (_level) {
        case UserLevelNovice:
            if ([textField.text integerValue] > 50) {
                textField.text = @"50";
            }
            break;
        case UserLevelAdvanced:
            if ([textField.text integerValue] > 100) {
                textField.text = @"100";
            } else if ([textField.text integerValue] < 50) {
                textField.text = @"50";
            }
            break;
        case UserLevelMaster:
            if ([textField.text integerValue] > 500) {
                textField.text = @"500";
            } else if ([textField.text integerValue] < 100) {
                textField.text = @"100";
            }
            break;
        case UserLevelInternational:
            if ([textField.text integerValue] > 1000) {
                textField.text = @"1000";
            } else if ([textField.text integerValue] < 500) {
                textField.text = @"500";
            }
            break;
            
        default:
            break;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (IBAction)valueChanged:(UITextField *)sender {
    if (_level == UserLevelInternational) {
        _totalPriceLabel.text = [NSString stringWithFormat:@"买入%@YUU，出价%@ETH，总价%0.4fETH",_countTextField.text, _myPrice.text, [_countTextField.text floatValue] * [_myPrice.text floatValue]];
    } else {
        _totalPriceLabel.text = [NSString stringWithFormat:@"买入%@YUU，出价%@元，总价%0.2f元",_countTextField.text, _myPrice.text, [_countTextField.text floatValue] * [_myPrice.text floatValue]];
    }
}


- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
            
        }
        i++;
        
    }
    return res;
}

#pragma mark - PendingMailboxCellDelegate -
- (void)mailCellStatusChanged {
    [self getMailInfo];
}

- (void)buyerCellStatusChanged {
    [self getBuyerInfo];
}


- (IBAction)noticeAction:(id)sender {
    YUUPendingNoticeVC *vc = [YUUPendingNoticeVC storyboardInstanceType];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
