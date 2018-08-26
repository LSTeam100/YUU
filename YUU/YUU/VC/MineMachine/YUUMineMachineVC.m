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

@interface YUUMineMachineVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *computePowerImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ouputImageView;

@property (strong, nonatomic) IBOutlet UILabel *computePowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation YUUMineMachineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"矿机";
    _ouputImageView.hidden = YES;
    
    YUUMachineModel *model = [[YUUMachineModel alloc] init];
    model.status = YUUMachineStatusDefault;
    model.machineNumber = @"S00922";
    model.type = YUUMachineTypeNew;
    model.operationDay = 5;
    model.operationCycle = 200;
    model.output = 12.8;
    model.receive = YUUMachineReceiveNo;
    _items = [NSMutableArray array];
    [_items addObject:model];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUUMineMachineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineMachineCell"];
    cell.model = _items[indexPath.row];
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
}

- (IBAction)outputImageViewTap:(id)sender {
    _computePowerImageView.hidden = YES;
    _ouputImageView.hidden = NO;
}


@end
