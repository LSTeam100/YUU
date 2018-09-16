//
//  YUUProfileCtrl.m
//  YUU
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUProfileCtrl.h"
#import "YUUMineDetailCtrl.h"
#import "YUUBillCenterCtrl.h"
#import "YUUCurrencyTransactionCtrl.h"
#import "YUUMessageCtrl.h"
#import "YUUSetingCtrl.h"
#import "YUUProfileAuthenEditeCtrl.h"
#import "YUUCommonModel.h"
#import "YUULauchAppRequest.h"
#import "YUUUserData.h"
#import "HUD.h"
#import "YUUProfileAuthenCtrl.h"
#import "YUUCallCenterCtrl.h"
@interface YUUProfileCtrl ()
@property(nonatomic,weak)IBOutlet UIButton *mineBtn;
@property(nonatomic,weak)IBOutlet UIButton *billBtn;
@property(nonatomic,weak)IBOutlet UIButton *coinBtn;
@property(nonatomic,weak)IBOutlet UIButton *bussniessBtn;
@property(nonatomic,weak)IBOutlet UIButton *costomBtn;
@property(nonatomic,weak)IBOutlet UIButton *gamesBtn;
@property(nonatomic,weak)IBOutlet UILabel *profileIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *profileGradeLabel;
@property(nonatomic,weak)IBOutlet UIButton *profileIsAuthenBtn;
@property(nonatomic,weak)IBOutlet UIButton *messageBtn;
@property(nonatomic,weak)IBOutlet UIButton *settingBtn;
@property(nonatomic,weak)IBOutlet UILabel *assetLabel;
@property(nonatomic,weak)IBOutlet UILabel *availbleLabel;
@property(nonatomic,weak)IBOutlet UILabel *freezeLabel;
@property(nonatomic,weak)IBOutlet UILabel *lockLabel;
@property(nonatomic,strong)YUUCommonModel *userModel;
@end

@implementation YUUProfileCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    // Do any additional setup after loading the view.
    [self updateUI];
}
//<<<<<<< HEAD
//-(void)setupUI{
//    self.profileIdLabel.text = [NSString stringWithFormat:@"ID:%@",self.userModel.memberid];
//    self.profileGradeLabel.text = [NSString stringWithFormat:@"等级:%@",self.userModel.membergrade];
//=======
-(void)updateUI{
    self.profileIdLabel.text = [NSString stringWithFormat:@"ID:%@",self.userModel.memberid];
    self.profileGradeLabel.text = [NSString stringWithFormat:@"等级:%@",self.userModel.membergrade];
    self.assetLabel.text = [NSString stringWithFormat:@"%@",self.userModel.propertynum];
    self.availbleLabel.text = [NSString stringWithFormat:@"可用YUU:%@",self.userModel.canuseyuu];
    self.freezeLabel.text = [NSString stringWithFormat:@"冻结YUU:%@",self.userModel.frozenyuu];
    self.lockLabel.text = [NSString stringWithFormat:@"锁仓YUU:%@",self.userModel.lockedyuu];
    self.profileIdLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.profileGradeLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.assetLabel.textColor = colorWithHexString(@"ED6621", 1);

    [self setupAuthenBtn];
}

-(void)setupAuthenBtn{
    if (self.userModel) {
        if ([self.userModel.certification intValue] == 1) {
            [self.profileIsAuthenBtn setBackgroundImage:[UIImage imageNamed:@"profile_alauth"] forState:UIControlStateNormal];

        }
        else{
            [self.profileIsAuthenBtn setBackgroundImage:[UIImage imageNamed:@"profile_unauth"] forState:UIControlStateNormal];
        }
    }
    else{
        [self.profileIsAuthenBtn setBackgroundImage:[UIImage imageNamed:@"profile_unauth"] forState:UIControlStateNormal];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *token = [YUUUserData shareInstance].userModel.token;
    [self setBusyIndicatorVisible:YES];
    YUULauchAppRequest *lauch = [[YUULauchAppRequest alloc]initWithAppRequest:token SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        self.userModel = [request getResponse].data;
        [self updateUI];

    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 1:
                DLOG(@"token无效");
                break;
            case 2:
                DLOG(@"用户被锁定");
                break;
            case 3:
                DLOG(@"闭市");
                break;
            default:
                break;
        }
    
        [HUD showHUDTitle:res.msg durationTime:2];

    }];
    
    [lauch start];
}

-(IBAction)naviToMine:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUMineDetailCtrl *mine = [sb instantiateViewControllerWithIdentifier:@"YUUMineDetailCtrl"];
    [self.navigationController pushViewController: mine animated:YES];
}
-(IBAction)naviToBill:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUBillCenterCtrl *bill = [sb instantiateViewControllerWithIdentifier:@"YUUBillCenterCtrl"];
    bill.assetMoney = self.assetLabel.text;
    [self.navigationController pushViewController: bill animated:YES];
}
-(IBAction)naviToCoin:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     YUUCurrencyTransactionCtrl *currency = [sb instantiateViewControllerWithIdentifier:@"YUUCurrencyTransactionCtrl"];
    currency.avalibleMoney = [NSString stringWithFormat:@"%@",self.userModel.canuseyuu];
    [self.navigationController pushViewController: currency animated:YES];
}
-(IBAction)naviToBussniess:(id)sender{
    [HUD showHUDTitle:@"敬请期待" durationTime:2];

}
-(IBAction)naviToCostom:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUCallCenterCtrl *callcenter = [sb instantiateViewControllerWithIdentifier:@"YUUCallCenterCtrl"];
    [self.navigationController pushViewController: callcenter animated:YES];

    
}
-(IBAction)naviToGames:(id)sender{
    [HUD showHUDTitle:@"敬请期待" durationTime:2];
}

-(IBAction)naviToMesage:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUMessageCtrl *message = [sb instantiateViewControllerWithIdentifier:@"YUUMessageCtrl"];
    [self.navigationController pushViewController: message animated:YES];
}

-(IBAction)naviToSetting:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUSetingCtrl *setting = [sb instantiateViewControllerWithIdentifier:@"YUUSetingCtrl"];
    [self.navigationController pushViewController:setting animated:YES];
}
-(IBAction)authenId:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (self.userModel) {
        if ([self.userModel.certification intValue] == 1) {
            YUUProfileAuthenCtrl * already = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenCtrl"];
            [self.navigationController pushViewController:already animated:YES];
        }
        else{
            YUUProfileAuthenEditeCtrl * edite = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenEditeCtrl"];
            [self.navigationController pushViewController:edite animated:YES];
        }
    }
    else{
        YUUProfileAuthenEditeCtrl * edite = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenEditeCtrl"];
        [self.navigationController pushViewController:edite animated:YES];
    }
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
