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
    
    {
        _model = [[MineralPoolModel alloc] init];
        _model.millspoolpower = 50;
        _model.totalminers = 100;
        _model.totaldirect = 51;
        _model.actminer = 30;
        _model.oneminer = 11;
        _model.twominer = 22;
        _model.threeminer = 33;
        _model.fourminer = 44;
        
        DirectPushModel *d = [[DirectPushModel alloc] init];
        d.headphoto = @"";
        d.membergrade = @"123";
        d.memberid = 123;
        d.memberpower = 111;
        d.membertotalmills = 111;
        d.membertotaldirect = 111;
        d.membertotalnodirect = 111;
        d.memberphone = 12345;
        _model.directid = @[d, d];
        
        TeamPushModel *t = [[TeamPushModel alloc] init];
        t.headphoto = @"";
        t.membergrade = @"222";
        t.memberid = 222;
        t.memberpower = 2222;
        t.membertotalmills = 222;
        t.membertotaldirect = 222;
        t.membertotalnodirect = 222;
        _model.nodirectid = @[t, t];
    }
    self.isDirect = YES;
    [self getHTTPData];
}

- (void)getHTTPData {
    WeakSelf
    GetMineralPoolRequest *request = [[GetMineralPoolRequest alloc] initWithSuccess:^(YUUBaseRequest *request) {
        weakSelf.model = request.getResponse.data;
        [weakSelf updateUI];
    } failure:^(YUUBaseRequest *request) {
        if (request.getResponse.code == 4) {
            weakSelf.model = nil;
            [weakSelf updateUI];
        }
        NSLog(@"");
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
    
//    [segment setTitles:@[@"直推" ,@"团队"] segmentSelectedAtIndex:^(NSInteger index) {
//        if (index == 0) {
//            YUUUserInfoView *view = [YUUUserInfoView xibInstancetype];
//            view.delegate = self;
//            view.textField0.text = @"28346879";
//            [HUD showCustomView:view];
//        } else {
//            YUUTeamInfoView *view = [YUUTeamInfoView xibInstancetype];
//            view.delegate = self;
//            [HUD showCustomView:view];
//        }
//    }];
    
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
        view.textField0.text = [NSString stringWithFormat:@"%ld", (long)model.memberid];
        view.textField1.text = [NSString stringWithFormat:@"%ld", (long)model.memberphone];
        [HUD showCustomView:view];
    } else {
//        YUUMachinePoolModel *model = self.model.nodirectidArr[indexPath.section];
//        YUUTeamInfoView *view = [YUUTeamInfoView xibInstancetype];
//        view.delegate = self;
//        [HUD showCustomView:view];
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