//
//  YUUBillCenterCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBillCenterCtrl.h"
#import "YUUBillCenterRequest.h"
#import "YUUUserData.h"
#import "HUD.h"
#import "YUUBillModel.h"

typedef enum {
    billTypeAll    =  -1,
    billTypeIn     =  0,
    billTypeOut    =  1,
    billTypeIncome =  2,
    billTypeReward =  3,
    billTypePay    =  4,
    billTypeFreeze =  5,
}billType;

@implementation YUUBillCenterCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177", 1);
    self.tailLabel.textColor = colorWithHexString(@"e4c177", 1);
    self.detailLabel.textColor = [UIColor whiteColor];

}

@end

@interface YUUBillCenterCtrl ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak)IBOutlet UILabel *moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel *moneyFlayLabel;
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *scrBtnArr;
@property(nonatomic,strong)YUUBillModelList *BillModelList;
@property(nonatomic,assign)billType selectBillType;
@property(nonatomic,strong)NSMutableArray *selectTypeArr;

@end

@implementation YUUBillCenterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单中心";
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.moneyLabel.text = self.assetMoney;
    self.moneyLabel.textColor = colorWithHexString(@"ED6621", 1);
    self.moneyFlayLabel.textColor = colorWithHexString(@"ED6621", 1.0);
    [self createScrollViewArr];
    self.selectBillType = billTypeAll;
    [self billCenterRequest];
    // Do any additional setup after loading the view.
}
-(void)billCenterRequest{
    [self setBusyIndicatorVisible:YES];
    NSString *token =[YUUUserData shareInstance].userModel.token;
    YUUBillCenterRequest *bill = [[YUUBillCenterRequest alloc]initWithBillCenter:token SuccessCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        self.BillModelList = [request getResponse].data;
        [self sortArrWithBillType];
        [self.tableView reloadData];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        YUUResponse *res = [request getResponse];
        [HUD showHUDTitle:res.msg durationTime:2];

    }];
    [bill start];
}


-(void)createScrollViewArr{
    NSArray *dataArr = @[@"全部",@"转入",@"转出",@"收益",@"奖励",@"支出",@"冻结"];
    [self InitScrBtnFactory:dataArr];
    for (UIButton *btn in self.scrBtnArr) {
        [self.scrollView addSubview:btn];
    }
    UIButton *lastBtn = [self.scrBtnArr lastObject];
    [self.scrollView setContentSize:CGSizeMake(lastBtn.frame.origin.x + lastBtn.frame.size.width, lastBtn.frame.size.height)];

    
}
-(void)InitScrBtnFactory:(NSArray *)dataArr{
    self.scrBtnArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < dataArr.count; i++) {
        NSString *title = dataArr[i];
        int btnWith = 60;
        int btnHeight = 40;
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        int offsetX = i * btnWith;
        [btn setFrame:CGRectMake(offsetX, 0, btnWith, btnHeight)];
        [btn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [btn setTitleColor:colorWithHexString(@"ff9141", 1.0) forState:UIControlStateNormal];
        }
        [self.scrBtnArr addObject:btn];
    }
}
-(void)selectType:(UIButton *)clickBtn{
    for (UIButton *btn in self.scrBtnArr) {
        if (btn == clickBtn) {
            [btn setTitleColor:colorWithHexString(@"ff9141", 1.0) forState:UIControlStateNormal];
        }
        else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    if ([clickBtn.titleLabel.text isEqualToString:@"全部"]) {
        self.selectBillType = billTypeAll;
        
    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"转入"]){
        self.selectBillType = billTypeIn;
    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"转出"]){
        self.selectBillType = billTypeOut;

    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"收益"]){
        self.selectBillType = billTypeIncome;
    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"奖励"]){
        self.selectBillType = billTypeReward;
    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"支出"]){
        self.selectBillType = billTypePay;
    }
    else if ([clickBtn.titleLabel.text isEqualToString:@"冻结"]){
        self.selectBillType = billTypeFreeze;
    }
    DLOG(@"title=%@",clickBtn.titleLabel.text);

    
    [self sortArrWithBillType];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idnetifer = @"YUUBillCenterCell";
    YUUBillCenterCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:idnetifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YUUBillModel *model = [self.selectTypeArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.billname;
    cell.detailLabel.text = model.billtime;
    cell.tailLabel.text = [NSString stringWithFormat:@"%@",model.billnum];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectTypeArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSMutableArray *)aseembleArr:(billType)type{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (YUUBillModel *model in self.BillModelList.billModelArr) {
        if ([model.billtype intValue] == type) {
            [arr addObject:model];
        }
    }
    return arr;
}
-(void)sortArrWithBillType{
    
    if (self.selectBillType == billTypeAll) {
        self.selectTypeArr = self.BillModelList.billModelArr;
    }
    else if (self.selectBillType == billTypeIn){
        self.selectTypeArr = [self aseembleArr:billTypeIn];
    }
    else if (self.selectBillType == billTypeOut){
        self.selectTypeArr = [self aseembleArr:billTypeOut];
    }
    else if (self.selectBillType == billTypeIncome){
        self.selectTypeArr = [self aseembleArr:billTypeIncome];
    }
    else if (self.selectBillType == billTypeReward){
        self.selectTypeArr = [self aseembleArr:billTypeReward];
    }
    else if (self.selectBillType == billTypePay){
        self.selectTypeArr = [self aseembleArr:billTypePay];
    }
    else if (self.selectBillType == billTypePay){
        self.selectTypeArr = [self aseembleArr:billTypePay];
    }
    else if (self.selectBillType == billTypeFreeze){
        self.selectTypeArr = [self aseembleArr:billTypeFreeze];
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
