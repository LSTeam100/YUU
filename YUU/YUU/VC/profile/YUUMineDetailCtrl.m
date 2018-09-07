//
//  YUUMineDetailCtrl.m
//  YUU
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineDetailCtrl.h"
#import "YUUMineDetailRequest.h"
#import "YUUUserData.h"
#import "YUUMineDetailModel.h"
#import "HUD.h"
#import "YUUUserData.h"
#import "YUUProfileAuthenEditeCtrl.h"
#import "YUUProfileAuthenCtrl.h"
#import "YUUCreditCard.h"
@implementation profileAuthenCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177",1);
    self.titleLabel.textColor = colorWithHexString(@"e4c177",1);
    self.detailLabel.textColor = [UIColor whiteColor];
}
@end

@interface YUUMineDetailCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UILabel *superIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineGradeLabel;
@property(nonatomic,weak)YUUMineDetailModel *DetailModel;
@property(nonatomic,weak)YUUCommonModel *userModel;
@end

@implementation YUUMineDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userModel = [YUUUserData shareInstance].userModel;
    [self mineDetailRequest];
    
}
-(void)dataInit{
    self.superIdLabel.text = [NSString stringWithFormat:@"%@",self.DetailModel.upmemberid];
    self.mineIdLabel.text =  [NSString stringWithFormat:@"%@",self.DetailModel.memberphone];
    self.mineGradeLabel.text = [YUUUserData shareInstance].userModel.membergrade;


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}
-(void)mineDetailRequest{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    [self setBusyIndicatorVisible:YES];
    
    __weak typeof(self) weakSelf = self;
    YUUMineDetailRequest *mineDetial = [[YUUMineDetailRequest alloc]initWithMineDetail:token SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        YUUMineDetailModel *model = [request getResponse].data;
        weakSelf.DetailModel = model;
        [weakSelf dataInit];
        [weakSelf.tableView reloadData];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                break;
            case 1:
                DLOG(@"无效token");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
    }];
    [mineDetial start];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"profileAuthenCell";
    profileAuthenCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.authenBtn.tag = indexPath.row;
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"手机号验证";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.userModel.memberid];
            if ([self isAuthenPhone]) {
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_alauth"] forState:UIControlStateNormal];
            }
            else{
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_unauth"] forState:UIControlStateNormal];
            }
            cell.authenBtn.hidden = NO;
            cell.moreImageView.hidden = YES;
            break;
        case 1:
            if ([self isAuthenUser]) {
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_alauth"] forState:UIControlStateNormal];
            }
            else{
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_unauth"] forState:UIControlStateNormal];
            }
            cell.authenBtn.hidden = NO;
            cell.moreImageView.hidden = YES;
            cell.titleLabel.text = @"实名认证";
            cell.detailLabel.text = self.DetailModel.membername;
            break;
            case 2:
            if ([self isAuthenBank]) {
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_alauth"] forState:UIControlStateNormal];
            }
            else{
                [cell.authenBtn setBackgroundImage:[UIImage imageNamed:@"profile_unauth"] forState:UIControlStateNormal];
            }
            cell.authenBtn.hidden = NO;
            cell.moreImageView.hidden = YES;
            cell.titleLabel.text = @"银行卡认证";
            cell.detailLabel.text = self.DetailModel.bankcard;
            break;
            case 3:
            cell.detailLabel.text = self.DetailModel.memberwx;
            cell.authenBtn.hidden = YES;
            cell.moreImageView.hidden = NO;
            cell.titleLabel.text = @"微信";
            break;
            case 4:
            cell.detailLabel.text = self.DetailModel.memberalipay;
            cell.authenBtn.hidden = YES;
            cell.moreImageView.hidden = NO;
            cell.titleLabel.text = @"支付宝";

            break;
            case 5:
            cell.detailLabel.text = self.DetailModel.memberwallet;
            cell.authenBtn.hidden = YES;
            cell.moreImageView.hidden = NO;
            cell.titleLabel.text = @"虚拟钱包";

            break;
        default:
            break;
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(IBAction)authenAction:(UIButton *)clickBtn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    switch (clickBtn.tag) {
        case 0:
            DLOG(@"点击手机验证");
            break;
        case 1:
            if ([self isAuthenUser]) {
                YUUProfileAuthenCtrl * userAlready = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenCtrl"];
                [self.navigationController pushViewController:userAlready animated:YES];
            }
            else{
                YUUProfileAuthenEditeCtrl * edite = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenEditeCtrl"];
                [self.navigationController pushViewController:edite animated:YES];
            }
            break;
        case 2:
            if ([self isAuthenBank]) {
                YUUCreditCard * bank = [sb instantiateViewControllerWithIdentifier:@"YUUCreditCard"];
                [self.navigationController pushViewController:bank animated:YES];
            }
            else{
                YUUProfileAuthenEditeCtrl * edite = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenEditeCtrl"];
                [self.navigationController pushViewController:edite animated:YES];
            }
            break;
        default:
            break;
    }
    
}
-(BOOL)isAuthenUser{
    BOOL authen = false;
    if ([self.userModel.certification intValue] == 1) {
        authen = true;
    }
    return authen;
}
-(BOOL)isAuthenBank{
    BOOL authen = false;
    if (self.DetailModel.bankname != nil) {
        authen = true;
    }
    return authen;
}
-(BOOL)isAuthenPhone{
    BOOL authen = false;
    if (self.userModel.memberid != nil) {
        authen = true;
    }
    return authen;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
