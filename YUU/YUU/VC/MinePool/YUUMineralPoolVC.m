//
//  YUUMineralPoolVC.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMineralPoolVC.h"
#import "YUUMineralPoolCell.h"
#import "SHSegmentView.h"
#import "Header.h"
#import "YUUTeamInfoView.h"
#import "YUUUserInfoView.h"
//#import "YUUMachinepoolRequst.h"
//#import "YUUMachinePoolArrModel.h"
#import "GetMineralPoolRequest.h"

@interface YUUMineralPoolVC () <UITableViewDelegate, UITableViewDataSource, HUDProtocol>

@property (strong, nonatomic) IBOutlet UILabel *powerLabel;
@property (strong, nonatomic) IBOutlet UILabel *minerCountLabel;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) MineralPoolModel *model;
@property (nonatomic, assign) BOOL isDirect;

@end

@implementation YUUMineralPoolVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMineralPool" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"矿池";
    _items = [NSMutableArray array];
    
    [self addSegment];
   
    self.isDirect = YES;
    [self getHTTPData];
    
    WeakSelf
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getHTTPData];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHTTPData];
}

- (void)getHTTPData {
    WeakSelf
    GetMineralPoolRequest *request = [[GetMineralPoolRequest alloc] initWithSuccess:^(YUUBaseRequest *request) {
        weakSelf.model = request.getResponse.data;
        [weakSelf updateUI];
        
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(YUUBaseRequest *request) {
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 1:
                DLOG(@"token无效");
                break;
            case 2:
                DLOG(@"用户被锁定");
                showCostomAlert(@"local_alert", weakSelf.view.frame);
                break;
            case 3:
                DLOG(@"闭市");
                showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);
                break;
            case 4:
                weakSelf.model = nil;
                [weakSelf updateUI];
                break;
            default:
                [HUD showHUDTitle:res.msg durationTime:2];
                break;
        }
        [self handleResponseError:self request:request needToken:YES];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf handleResponseError:self request:request needToken:YES];
    }];

    [request start];
}

- (void)updateUI {
    if (_model) {
        _powerLabel.text = [NSString stringWithFormat:@"%ld",(long)_model.millspoolpower];
        _minerCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_model.totalminers];
    } else {
        _powerLabel.text = @"0";
        _minerCountLabel.text = @"0";
    }
    
    [_tableView reloadData];
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
    
    [segment setSegmentTitles:@[@"直推" ,@"团队"] segmentSelectedAtIndex:^(NSInteger index) {
        if (index == 0) {
            weakSelf.isDirect = YES;
            [weakSelf.tableView reloadData];
        } else {
            weakSelf.isDirect = NO;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (IBAction)showTeamMessage:(id)sender {
    if (!self.model) {
        return;
    }
    YUUTeamInfoView *view = [YUUTeamInfoView xibInstancetype];
    view.delegate = self;
    view.model = self.model;
    [HUD showCustomView:view];
}


- (void)closeBtnDidSelected {
    [HUD hide];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUUMineralPoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YUUMineralPoolCell"];
    if (_isDirect) {
        cell.directModel = self.model.directid[indexPath.section];
    } else {
        cell.teamModel = self.model.nodirectid[indexPath.section];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isDirect) {
        return self.model.directid.count;
    } else {
        return self.model.nodirectid.count;
    }
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDirect) {
        DirectPushModel *model = self.model.directid[indexPath.section];
        YUUUserInfoView *view = [YUUUserInfoView xibInstancetype];
        view.delegate = self;
//        view.textField0.text = [NSString stringWithFormat:@"%@", model.memberidStr];
        view.textField0.text = [NSString stringWithFormat:@"%ld", (long)model.memberid];

        view.textField1.text = [NSString stringWithFormat:@"%ld", (long)model.memberphone];
        [HUD showCustomView:view];
    } else {

    }
}

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
