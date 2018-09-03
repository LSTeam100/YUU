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

@end

@implementation YUUProfileCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    // Do any additional setup after loading the view.
}

-(IBAction)naviToMine:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUMineDetailCtrl *mine = [sb instantiateViewControllerWithIdentifier:@"YUUMineDetailCtrl"];
    [self.navigationController pushViewController: mine animated:YES];
}
-(IBAction)naviToBill:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUBillCenterCtrl *bill = [sb instantiateViewControllerWithIdentifier:@"YUUBillCenterCtrl"];
    [self.navigationController pushViewController: bill animated:YES];
}
-(IBAction)naviToCoin:(id)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     YUUCurrencyTransactionCtrl *currency = [sb instantiateViewControllerWithIdentifier:@"YUUCurrencyTransactionCtrl"];
    [self.navigationController pushViewController: currency animated:YES];
}
-(IBAction)naviToBussniess:(id)sender{
    
}
-(IBAction)naviToCostom:(id)sender{
    
}
-(IBAction)naviToGames:(id)sender{
    
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
    YUUProfileAuthenEditeCtrl * edite = [sb instantiateViewControllerWithIdentifier:@"YUUProfileAuthenEditeCtrl"];
    [self.navigationController pushViewController:edite animated:YES];
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
