//
//  YUUTransactionHistoryCtrl.m
//  YUU
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUTransactionHistoryCtrl.h"
#import "YUUCurrencyHistoryRequest.h"
#import "YUUUserData.h"
#import "YUUCurrencyHistoryModel.h"
#import "HUD.h"
@implementation transactionHistoryCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177", 1.0);
}

@end


@interface YUUTransactionHistoryCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong)YUUCurrencyHistoryArrModel *hisArrModel;

@end

@implementation YUUTransactionHistoryCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    self.tableView.backgroundColor = [UIColor clearColor];
    [self getHistory];
    // Do any additional setup after loading the view.
}
-(void)getHistory{
    NSString *token = [YUUUserData shareInstance].userModel.token;
    WeakSelf
    [self setBusyIndicatorVisible:YES];
    YUUCurrencyHistoryRequest *history = [[YUUCurrencyHistoryRequest alloc]initWithCurrencyHistory:token SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        weakSelf.hisArrModel = [request getResponse].data;
        [weakSelf.tableView reloadData];

    } failureCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        switch (res.code) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
        [HUD showHUDTitle:res.msg durationTime:2];
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];
    }];
    [history start];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hisArrModel.currencyHistoryArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"transactionHistoryCell";
    transactionHistoryCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    YUUCurrencyHistoryModel *m = self.hisArrModel.currencyHistoryArr[indexPath.row];
    cell.titleLabel.text = m.coinsite;
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",m.coinnum];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",m.cointime];

    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
