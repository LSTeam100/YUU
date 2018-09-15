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
#import "YUUUserSendwxRequest.h"
#import "YUUUserSendAlipayRequest.h"
#import "YUUUserSendWalletRequest.h"
#import "YUUViturlWallet.h"
@implementation profileAuthenCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177",1);
    self.titleLabel.textColor = colorWithHexString(@"e4c177",1);
    self.detailLabel.textColor = [UIColor whiteColor];
}
@end

@interface YUUMineDetailCtrl ()<UITableViewDelegate,UITableViewDataSource>

typedef enum {
    wechatType,
    aliPayType,
    walletType
}clickPayType;

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UILabel *superIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineGradeLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleSuperIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleMineIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleGradeLabel;


@property(nonatomic,strong)YUUMineDetailModel *DetailModel;
@property(nonatomic,strong)YUUCommonModel *userModel;
@property(nonatomic,assign)clickPayType clickType;
@end

@implementation YUUMineDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userModel = [YUUUserData shareInstance].userModel;
    self.titleGradeLabel.textColor = colorWithHexString(@"ED6621", 1.0);
    self.titleMineIdLabel.textColor = colorWithHexString(@"ED6621", 1.0);
    self.titleSuperIdLabel.textColor = colorWithHexString(@"ED6621", 1.0);
    [self mineDetailRequest];
    
}
-(void)dataInit{
    self.superIdLabel.text = [NSString stringWithFormat:@"%@",self.DetailModel.upmemberid];
    self.mineIdLabel.text =  [NSString stringWithFormat:@"%@",self.userModel.memberid];
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
        self.DetailModel = model;
        [self dataInit];
        [self.tableView reloadData];
        
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"手机号验证";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@",self.DetailModel.memberphone];
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
    DLOG(@"点击%ld行",(long)indexPath.row);
    
    NSString *msg = [[NSString alloc]init];
    switch (indexPath.row) {
        case 3:
            if (self.DetailModel.memberwx != nil && self.DetailModel.memberwx.length > 0) {
                [HUD showHUDTitle:@"如果需要更换，请联系客服" durationTime:2];
                return;
            }
            self.clickType = wechatType;
            msg = @"微信号只能填写一次，请谨慎填写";
            break;
        case 4:
            if (self.DetailModel.memberalipay != nil && self.DetailModel.memberalipay.length > 0) {
                [HUD showHUDTitle:@"如果需要更换，请联系客服" durationTime:2];
                return;
            }
            self.clickType = aliPayType;
            msg = @"支付宝账号只能填写一次，请谨慎填写";
            break;
        case 5:
            if (self.DetailModel.memberwallet != nil && self.DetailModel.memberwallet.length > 0) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                YUUViturlWallet *wallet = [sb instantiateViewControllerWithIdentifier:@"YUUViturlWallet"];
                wallet.virtualWalletStr = self.DetailModel.memberwallet;
                
                [self.navigationController pushViewController:wallet animated:YES];

                return;
            }
            self.clickType = walletType;
            break;
        default:
            break;
    }
    

    
    if ((self.clickType == wechatType || self.clickType == aliPayType || self.clickType == walletType) && indexPath.row >= 3) {
        
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
            if (alert.textFields.count > 0) {
                UITextField *textField  = alert.textFields[0];
                if (textField.text.length == 0) {
                    [HUD showHUDTitle:@"号码不能为空" durationTime:2];
                }
                else{
                    if (self.clickType == wechatType) {
                        [self sendWXRequest:textField.text];
                    }
                    else if (self.clickType == aliPayType){
                        [self sendAliRequest:textField.text];
                    }
                    else if (self.clickType == walletType){
                        [self sendWalletRequest:textField.text];
                    }
                }
            }
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            if (self.clickType == wechatType) {
                textField.placeholder = @"微信号";
            }
            else if (self.clickType == aliPayType){
                textField.placeholder = @"支付宝号";
            }
            else if (self.clickType == walletType){
                textField.placeholder = @"虚拟钱包";
            }
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
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
    if (self.DetailModel.bankname != nil && self.DetailModel.bankname.length > 0) {
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
-(void)sendWXRequest:(NSString *)wxNum{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    
    [self setBusyIndicatorVisible:YES];
    YUUUserSendwxRequest *sendWX = [[YUUUserSendwxRequest alloc]initWithSendwx:token Memberwx:wxNum SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [HUD showHUDTitle:@"微信注册成功" durationTime:2];
        [self mineDetailRequest];

    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"错误信息");
                break;
            case 1:
                DLOG(@"token无效");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        
        [HUD showHUDTitle:res.msg durationTime:2];
    }];
    [sendWX start];
}

-(void)sendAliRequest:(NSString *)aliNum{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    
    [self setBusyIndicatorVisible:YES];
    YUUUserSendAlipayRequest *ali = [[YUUUserSendAlipayRequest alloc]initWithSendAlipay:token Memberalipay:aliNum SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [HUD showHUDTitle:@"支付宝注册成功" durationTime:2];
        [self mineDetailRequest];

    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"错误信息");
                break;
            case 1:
                DLOG(@"token无效");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        
        [HUD showHUDTitle:res.msg durationTime:2];

        
    }];
    [ali start];
    
    
}

-(void)sendWalletRequest:(NSString *)walletNum{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    [self setBusyIndicatorVisible:YES];
    YUUUserSendWalletRequest *wallet = [[YUUUserSendWalletRequest alloc]initWithSendWallet:token Memberwallet:walletNum SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [HUD showHUDTitle:@"虚拟钱包注册成功" durationTime:2];
        [self mineDetailRequest];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                DLOG(@"错误信息");
                break;
            case 1:
                DLOG(@"token无效");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];

    }];
    [wallet start];
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
