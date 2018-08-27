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
    DLOG(@"111");
}

@end

@interface YUUBillCenterCtrl ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak)IBOutlet UILabel *moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel *moneyFlayLabel;
@property(nonatomic,weak)IBOutlet UITableView *tableView;

@end

@implementation YUUBillCenterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
