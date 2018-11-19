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
#import "YUUHistoryGamesModel.h"


typedef NS_ENUM(NSInteger , fightResult)  {
    fightResultLose = 0,
    fightResultAngry = 1,
    fightResultSame = 2,
    fightResultWin = 3,
    fightResultViolent = 4
};


@interface YUUGamesHistroy ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *historyArr;
    
}
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
    
    [self getHistroyReq];

    // Do any additional setup after loading the view.
}
-(void)getHistroyReq{
    NSString *token = [YUUUserData shareInstance].token;
    NSString *lastId = @"0";
    
    [self setBusyIndicatorVisible:YES];
    WeakSelf
    YUUHistoryscoreRequest *hisscore = [[YUUHistoryscoreRequest alloc]initWithHisScore:token LastId:lastId SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        NSDictionary *data = [request getResponse].data;
        NSArray *msgList = data[@"msgList"];
        historyArr = [NSMutableArray arrayWithArray:msgList];
        [self.tableView reloadData];
        
        
    } failureCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        [weakSelf handleResponseError:self request:request needToken:YES];

    }];
    [hisscore start];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return historyArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"GameHistroyCell";
    GameHistroyCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YUUHistoryGamesModel *model = historyArr[indexPath.row];
    cell.timeLabel.text = model.time;
    cell.otherIdLabel.text = [NSString stringWithFormat:@"%ld",[model.otherid longValue]];
    cell.firstIcon.image = [self fightResult:[model.firstbout integerValue]];
    cell.secIcon.image = [self fightResult:[model.secondbout integerValue]];
    cell.thirdIcon.image = [self fightResult:[model.thirdbout integerValue]];
    cell.firYuuLabel.text = regYUUCoin(model.firstgetyuu, 2);
    cell.secYuuLabel.text = regYUUCoin(model.secondgetyuu, 2);
    cell.thiYuuLabel.text = regYUUCoin(model.thirdgetyuu, 2);
    cell.firPohintLabel.text = regYUUCoin(model.firstboutintegral, 2);
    cell.secPohintLabel.text = regYUUCoin(model.secondboutintegral, 2);
    cell.thiYuuLabel.text = regYUUCoin(model.thirdboutintegral, 2);
    
    if ([model.attordef integerValue] == 0) {
        cell.statusImageView.image = [UIImage imageNamed:@"gamesHisStatusDefence"];
    }
    else{
        cell.statusImageView.image = [UIImage imageNamed:@"gamesHisStatusAttack"];
    }
   
    return cell;
}

-(UIImage *)fightResult:(NSInteger)result{
    UIImage *image;
    switch (result) {
        case fightResultLose:
            image = [UIImage imageNamed:@"his_lose"];
            break;
        case fightResultAngry:
            image = [UIImage imageNamed:@"his_his_angry"];
            break;
        case fightResultSame:
            image = [UIImage imageNamed:@"his_same"];
            break;
        case fightResultWin:
            image = [UIImage imageNamed:@"his_win"];
            break;
        case fightResultViolent:
            image = [UIImage imageNamed:@"his_violent"];
            break;
        default:
            break;
    }
    return image;
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
