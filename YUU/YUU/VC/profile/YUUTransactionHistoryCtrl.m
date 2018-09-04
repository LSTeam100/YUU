//
//  YUUTransactionHistoryCtrl.m
//  YUU
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUTransactionHistoryCtrl.h"

@implementation transactionHistoryCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177", 1.0);
}

@end


@interface YUUTransactionHistoryCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;


@end

@implementation YUUTransactionHistoryCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"transactionHistoryCell";
    transactionHistoryCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
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
