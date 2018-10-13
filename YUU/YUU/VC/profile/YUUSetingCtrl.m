//
//  YUUSetingCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSetingCtrl.h"
#import "YUUModifyPassword.h"
#import "YUUUserData.h"
#import "YUUMineDetailRequest.h"
#import "YUUMineDetailModel.h"
#import "YUUTabBarController.h"
@implementation YUUSetingCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177",1);
    self.titleLabel.textColor = colorWithHexString(@"e4c177",1);
    self.moreImageView.hidden = YES;
}

@end


@interface YUUSetingCtrl ()
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIButton *logoutBtn;
@property(nonatomic,weak)YUUMineDetailModel *DetailModel;
@end

@implementation YUUSetingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)mineDetailRequest{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    [self setBusyIndicatorVisible:YES];
    
    __weak typeof(self) weakSelf = self;
    YUUMineDetailRequest *mineDetial = [[YUUMineDetailRequest alloc]initWithMineDetail:token SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        YUUMineDetailModel *model = [request getResponse].data;
        self.DetailModel = model;
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
        [self handleResponseError:self request:request needToken:YES];
        [HUD showHUDTitle:res.msg durationTime:2];
    }];
    [mineDetial start];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUSetingCell";
    YUUSetingCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    switch (indexPath.row) {
//        case 0:
//            cell.titleLabel.text = @"微信公众号";
//            cell.lastLabel.text = self.DetailModel.memberwx;
//            break;
        case 0:
            cell.titleLabel.text = @"当前版本";
            cell.lastLabel.text = app_Version;
            break;
        case 1:
            cell.titleLabel.text = @"修改登录密码";
            cell.lastLabel.hidden = YES;
            cell.moreImageView.hidden = NO;
            break;
        case 2:
            cell.titleLabel.text = @"修改交易密码";
            cell.lastLabel.hidden = YES;
            cell.moreImageView.hidden = NO;
            break;
        default:
            break;
    }

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YUUModifyPassword *modiy = [sb instantiateViewControllerWithIdentifier:@"YUUModifyPassword"];

    switch (indexPath.row) {
        case 1:
            modiy.modifyType = loginType;
            [self.navigationController pushViewController:modiy animated:YES];
            break;
        case 2:
            modiy.modifyType = transactionType;
            [self.navigationController pushViewController:modiy animated:YES];
            break;
        default:
        break;
            
    }
    DLOG(@"row=%d",indexPath.row);
}

-(IBAction)loginOut:(id)sender{
    [[YUUUserData shareInstance]removeUserData];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
    WeakSelf
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navi = [sb instantiateViewControllerWithIdentifier:@"loginNavi"];
    [self presentViewController:navi animated:YES completion:^{
         [weakSelf.navigationController popViewControllerAnimated:YES];
        if ([root isKindOfClass:[YUUTabBarController class]]) {
            YUUTabBarController *tabbar = (YUUTabBarController *)root;
            [tabbar setSelectedIndex:0];
           
        }
        DLOG(@"展示登录页面");
    }];

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
