//
//  YUUSetingCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSetingCtrl.h"
#import "YUUModifyPassword.h"
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
@end

@implementation YUUSetingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUSetingCell";
    YUUSetingCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"微信公众号";
            break;
        case 1:
            cell.titleLabel.text = @"当前版本";
            break;
        case 2:
            cell.titleLabel.text = @"修改登录密码";
            cell.lastLabel.hidden = YES;
            cell.moreImageView.hidden = NO;
            break;
        case 3:
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
        case 2:
            modiy.modifyType = loginType;
            [self.navigationController pushViewController:modiy animated:YES];
            break;
        case 3:
            modiy.modifyType = transactionType;
            [self.navigationController pushViewController:modiy animated:YES];
            break;
        default:
        break;
            
    }
    DLOG(@"row=%d",indexPath.row);
}

-(IBAction)loginOut:(id)sender{
    
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
