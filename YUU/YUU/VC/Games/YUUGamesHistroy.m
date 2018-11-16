//
//  YUUGamesHistroy.m
//  YUU
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUGamesHistroy.h"
#import "GameHistroyCell.h"
#import "YUUHistoryscoreRequest.h"
#import "YUUUserData.h"
@interface YUUGamesHistroy ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIView *topView;
@property(nonatomic,weak)IBOutlet UILabel *topLabel;
@property(nonatomic,weak)IBOutlet UIView *titleBgView;

@end

@implementation YUUGamesHistroy

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攻守令";
    self.tableView.delegate =self;
    self.topView.layer.borderColor = [colorWithHexString(@"52B2C6", 1) CGColor];
    
    self.topView.layer.borderWidth = 1.0;
    self.topView.backgroundColor = [UIColor clearColor];
    self.titleBgView.backgroundColor = colorWithHexString(@"52B2C6", 1.0);
    self.topLabel.textColor = colorWithHexString(@"52B2C6", 1.0);
    self.topView.layer.cornerRadius = 10;
    
    

    // Do any additional setup after loading the view.
}
-(void)getHistroyReq{
//    NSString *token = [YUUUserData shareInstance].token;
//    YUUHistoryscoreRequest *hisscore = [YUUHistoryscoreRequest alloc]initWithHisScore:token LastId:<#(NSString *)#> SuccessCallback:^(YUUBaseRequest *request) {
//        <#code#>
//    } failureCallback:<#^(YUUBaseRequest *request)failed#>
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"GameHistroyCell";
    GameHistroyCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
