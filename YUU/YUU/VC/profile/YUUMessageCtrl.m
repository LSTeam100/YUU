//
//  YUUMessageCtrl.m
//  YUU
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMessageCtrl.h"
#import "YUUMessageDetailCtrl.h"

@implementation YUUMessageCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.backgroundColor = colorWithHexString(@"e4c177",0.15);
    self.bgView.layer.borderWidth = 1.0;
    self.bgView.layer.borderColor = [colorWithHexString(@"e4c177",1) CGColor];
    self.titleLabel.textColor = colorWithHexString(@"e4c177",1);
    self.detailLabel.textColor = [UIColor whiteColor];
    self.dateLabel.textColor = [UIColor whiteColor];

}

@end


@interface YUUMessageCtrl ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tableView;

@end

@implementation YUUMessageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    self.tableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUMessageCell";
    YUUMessageCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLOG(@"click=%ld",(long)indexPath.row);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    YUUMessageDetailCtrl *detail = [sb instantiateViewControllerWithIdentifier:@"YUUMessageDetailCtrl"];
    [self.navigationController pushViewController:detail animated:YES];
    
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
