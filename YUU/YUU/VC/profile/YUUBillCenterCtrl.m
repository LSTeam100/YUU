//
//  YUUBillCenterCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBillCenterCtrl.h"


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

@end

@implementation YUUBillCenterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单中心";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self createScrollViewArr];
    // Do any additional setup after loading the view.
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
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idnetifer = @"YUUBillCenterCell";
    YUUBillCenterCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:idnetifer];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
