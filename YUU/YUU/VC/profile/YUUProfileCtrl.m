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
@property(nonatomic,weak)IBOutlet UIImageView *headImageView;
@property(nonatomic,weak)IBOutlet UIView *newsRedIcon;

@property(nonatomic,strong)YUUCommonModel *userModel;
@end

@implementation YUUProfileCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    // Do any additional setup after loading the view.
    [self updateUI];
}

-(void)updateUI{
    self.profileIdLabel.text = [NSString stringWithFormat:@"ID:%@",self.userModel.memberid];
    self.profileGradeLabel.text = [NSString stringWithFormat:@"等级:%@",self.userModel.membergrade];
    
//    float propertynum = [self.userModel.propertynum floatValue];
//    float forzen = [self.userModel.frozenyuu floatValue];
//    float lock = [self.userModel.lockedyuu floatValue];
    
//    self.assetLabel.text = [NSString stringWithFormat:@"%.6f",propertynum];
    
    self.assetLabel.text = self.userModel.propertynum.description;
    
    
//    float canuse = [self.userModel.canuseyuu floatValue];
    NSString *canuseStr = regYUUCoin(self.userModel.canuseyuu, 3);
    self.availbleLabel.text = [NSString stringWithFormat:@"可用YUU:%@",canuseStr];
    
    
    
    self.freezeLabel.text = [NSString stringWithFormat:@"冻结YUU:%@",regYUUCoin(self.userModel.frozenyuu, 3)];
    self.lockLabel.text = [NSString stringWithFormat:@"锁仓YUU:%@",self.userModel.lockedyuu];
    self.profileIdLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.profileGradeLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.assetLabel.textColor = colorWithHexString(@"ED6621", 1);
    DLOG(@"membergrade=%@",self.userModel.membergrade);
    self.headImageView.image = getHeadPhoto(self.userModel.membergrade);
    
    self.newsRedIcon.backgroundColor = colorWithHexString(@"d82e2e", 1.0);
    self.newsRedIcon.layer.cornerRadius = 4;
    if ([self.userModel.newnews intValue] == 1) {
        [self.newsRedIcon setHidden:NO];
    }
    else{
        [self.newsRedIcon setHidden:true];

    }

    

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
    WeakSelf
    [self setBusyIndicatorVisible:YES];
    YUULauchAppRequest *lauch = [[YUULauchAppRequest alloc]initWithAppRequest:token SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        self.userModel = [request getResponse].data;
        [self updateUI];

    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
//        YUUResponse *res = [request getResponse];
//        switch (res.code) {
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
//            default:
//                [HUD showHUDTitle:res.msg durationTime:2];
//                break;
//        }
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];

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
    currency.avalibleMoney = self.userModel.canuseyuu;
    [self.navigationController pushViewController: currency animated:YES];
}
-(IBAction)naviToBussniess:(id)sender{
    UIImage *img = [UIImage imageNamed:@"bussness_alert"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = img;
    [HUD showCustomView:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide];
    });

}
-(IBAction)naviToCostom:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUCallCenterCtrl *callcenter = [sb instantiateViewControllerWithIdentifier:@"YUUCallCenterCtrl"];
    [self.navigationController pushViewController: callcenter animated:YES];

    
}
-(IBAction)naviToGames:(id)sender{
    UIImage *img = [UIImage imageNamed:@"holdon"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = img;
    [HUD showCustomView:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide];
    });
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
//            YUUProfileAuthenCtrl * already = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenCtrl"];
//            [self.navigationController pushViewController:already animated:YES];
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
