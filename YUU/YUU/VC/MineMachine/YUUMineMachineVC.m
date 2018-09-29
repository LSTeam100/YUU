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
    
    [self getHTTPData];
}

- (void)getHTTPData {
    WeakSelf
    [_workingItems removeAllObjects];
    [_doneItems removeAllObjects];
    YUUMachineListRequest *request = [[YUUMachineListRequest alloc] initWithMachineList:[YUUUserData shareInstance].token SuccessCallback:^(YUUBaseRequest *request) {
        weakSelf.arrModel = request.getResponse.data;
        for (YUUMachineDetailModel *model in weakSelf.arrModel.msgList) {
            if (model.milldie == YUUMachineStatusWorking) {
                [weakSelf.workingItems addObject:model];
            } else {
                [weakSelf.doneItems addObject:model];
            }
        }
        [weakSelf updateUI];
    } failureCallback:^(YUUBaseRequest *request) {
        if (request.getResponse.code == 4) {
            [weakSelf.workingItems removeAllObjects];
            [weakSelf.doneItems removeAllObjects];
            [weakSelf updateUI];
        }
    }];
    [request start];
}

- (void)updateUI {
    _computePowerLabel.text = [NSString stringWithFormat:@"%ld",(long)_arrModel.memberpower];
    _outputLabel.text = [NSString stringWithFormat:@"%0.2f",_arrModel.memberdaycoin];
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
