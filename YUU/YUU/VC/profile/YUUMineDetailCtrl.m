//
//  YUUMineDetailCtrl.m
//  YUU
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineDetailCtrl.h"

@implementation profileAuthenCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177",1);
    self.titleLabel.textColor = colorWithHexString(@"e4c177",1);
    self.detailLabel.textColor = [UIColor whiteColor];
}
@end

@interface YUUMineDetailCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UILabel *superIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *mineGradeLabel;

@end

@implementation YUUMineDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.tableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"profileAuthenCell";
    profileAuthenCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
