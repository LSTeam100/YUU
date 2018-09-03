//
//  YUUCurrencyTransactionCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCurrencyTransactionCtrl.h"
#import "YUUTransactionHistoryCtrl.h"
@implementation YUUCurrencyCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177", 1.0);
    self.titleLabel.textColor = colorWithHexString(@"e4c177", 1.0);
    self.contenLabel.textColor = [UIColor whiteColor];
    
}

@end


@interface YUUCurrencyTransactionCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIButton *leftSelectBtn;
@property(nonatomic,weak)IBOutlet UIButton *rightSelectBtn;

@end

@implementation YUUCurrencyTransactionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"币币交易";
    self.tableView.backgroundColor = [UIColor clearColor];
    [self initSegmentBar];
    [self setCustomBackItem];
    
    UIBarButtonItem *histroyItem = [[UIBarButtonItem alloc]initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(naviToHistoryController)];
    self.navigationItem.rightBarButtonItem = histroyItem;

//    self.navigationController.navigationItem.rightBarButtonItem = histroyItem;

}
-(void)naviToHistoryController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    YUUTransactionHistoryCtrl *his = [sb instantiateViewControllerWithIdentifier:@"YUUTransactionHistoryCtrl"];
    [self.navigationController pushViewController:his animated:YES];
}
-(void)initSegmentBar{
    [self.leftSelectBtn setBackgroundImage:[UIImage imageNamed:@"btn_left_selected"] forState:UIControlStateNormal];
    [self.rightSelectBtn setBackgroundImage:nil forState:UIControlStateNormal];
}

-(IBAction)selectSegment:(UIButton *)clickBtn{
    if (clickBtn.tag == 0) {
        [self.leftSelectBtn setBackgroundImage:[UIImage imageNamed:@"btn_left_selected"] forState:UIControlStateNormal];
        [self.rightSelectBtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    else{
        [self.leftSelectBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.rightSelectBtn setBackgroundImage:[UIImage imageNamed:@"btn_right_selected"] forState:UIControlStateNormal];
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUCurrencyCell";
    YUUCurrencyCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    return cell;
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
