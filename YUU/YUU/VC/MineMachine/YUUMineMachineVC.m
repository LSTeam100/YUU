//
//  YUUMineMachineVC.m
//  YUU
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMachineVC.h"
#import "YUUMineMachineCell.h"
#import "YUUColor.h"
#import "YUUMachineListRequest.h"
#import "YUUMachineArrModel.h"

@interface YUUMineMachineVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *computePowerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ouputImageView;

@property (strong, nonatomic) IBOutlet UILabel *computePowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) YUUMachineArrModel *arrModel;
//@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *workingItems;
@property (nonatomic, strong) NSMutableArray *doneItems;
@property (nonatomic, assign) BOOL isWorking;

@end

@implementation YUUMineMachineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"矿机";
    _ouputImageView.hidden = YES;
    _workingItems = [NSMutableArray array];
    _doneItems = [NSMutableArray array];
    _isWorking = YES;
    
//    YUUMachineDetailModel *model = [[YUUMachineDetailModel alloc] init];
//    model.millsize = @"1";
//    model.milltype = @1;
//    model.runtimeday = @1;
//    model.totaldays = @1;
//    model.compower = @"1";
//    model.outputcoins = @1;
//    model.getmill = 1;
//    model.milldie = 1;
//
//    _workingItems = [NSMutableArray array];
//    [_workingItems addObject:model];
//    [_workingItems addObject:model];
//    
//    _doneItems = [NSMutableArray array];
//    [_doneItems addObject:model];
//    [_doneItems addObject:model];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHTTPData];

}

- (void)getHTTPData {
    WeakSelf
    YUUMachineListRequest *request = [[YUUMachineListRequest alloc] initWithMachineList:[YUUUserData shareInstance].token SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf.workingItems removeAllObjects];
        [weakSelf.doneItems removeAllObjects];
        weakSelf.arrModel = request.getResponse.data;
        for (YUUMachineDetailModel *model in weakSelf.arrModel.msgList) {
            if (model.milldie == YUUMachineStatusDefault) {
                [weakSelf.workingItems addObject:model];
            } else {
                [weakSelf.doneItems addObject:model];
            }
        }
        [weakSelf updateUI];
    } failureCallback:^(YUUBaseRequest *request) {
        YUUResponse *res = [request getResponse];
        _arrModel = nil;
        switch (res.code) {
//            case 1:
//                DLOG(@"token无效");
//                break;
//            case 2:
//                DLOG(@"用户被锁定");
//                showCostomAlert(@"local_alert", weakSelf.view.frame);
//                break;
//            case 3:
//                DLOG(@"闭市");
//                showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);
//                break;
            case 4:
                [weakSelf.workingItems removeAllObjects];
                [weakSelf.doneItems removeAllObjects];
                [weakSelf updateUI];
                break;
            default:
//                [HUD showHUDTitle:res.msg durationTime:2];
                break;
        }
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];

    }];
    [request start];
}

- (void)updateUI {
    if (_arrModel != nil) {
        _computePowerLabel.text = [NSString stringWithFormat:@"%ld",(long)_arrModel.memberpower];
//        _outputLabel.text = [NSString stringWithFormat:@"%0.2f",_arrModel.memberdaycoin];
        _outputLabel.text = regYUUCoin([NSNumber numberWithDouble:_arrModel.memberdaycoin], 3);

    }
    else{
        _computePowerLabel.text = @"0";
        _outputLabel.text = @"0";

    }
        [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isWorking) {
        return _workingItems.count;
    } else {
        return _doneItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUUMineMachineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMachineCell"];
    if (_isWorking) {
        cell.model = _workingItems[indexPath.row];
    } else {
        cell.model = _doneItems[indexPath.row];
    }
    
    return cell;
}

//#pragma mark - UITableViewDelegate -
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 38;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
//    aview.backgroundColor = YUUYellow;
//    aview.alpha = 0.3;
//    return aview;
//}



- (IBAction)computePowerImageViewTap:(id)sender {
    _computePowerImageView.hidden = NO;
    _ouputImageView.hidden = YES;
    
    _isWorking = YES;
    [_tableView reloadData];
}

- (IBAction)outputImageViewTap:(id)sender {
    _computePowerImageView.hidden = YES;
    _ouputImageView.hidden = NO;
    
    _isWorking = NO;
    [_tableView reloadData];
}


@end
