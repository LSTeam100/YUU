//
//  YUUChatCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatCtrl.h"
#import "YUUChatMessageCell.h"
#import "YUUDatabaseMgr.h"
#import "YUUHappycallRequest.h"
#import "ChatMsgModel.h"
#import "YUUCallNowRequest.h"
#import "YUUUserData.h"
static  NSString * const chatTable = @"chatTable";


@interface YUUChatCtrl ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat originInputTopMargin;
    NSMutableArray *msgArr;

}
    @property (weak, nonatomic) IBOutlet UIView *chatBgView;
    @property (weak, nonatomic) IBOutlet UIView *chatBottomView;
    @property (weak, nonatomic) IBOutlet UITextField *chatTextField;
    @property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;
    @property (weak, nonatomic) IBOutlet UITableView *messageList;
    @property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;
    @property(nonatomic,weak)IBOutlet NSLayoutConstraint *chatViewHeight;
    @property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;

@end

@implementation YUUChatCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    msgArr = [[NSMutableArray alloc]init];
    self.title = @"畅所欲言";
    self.chatViewHeight.constant = [UIScreen mainScreen].bounds.size.height * 0.86;
    self.chatBgView.layer.borderWidth = 1.0;
    self.chatBgView.layer.borderColor = YUUYellow.CGColor;
    self.chatBgView.backgroundColor = [UIColor clearColor];
    self.chatBgView.layer.cornerRadius = 10;
    self.chatTextField.layer.borderWidth = 1.0;
    self.chatTextField.layer.borderColor = YUUYellow.CGColor;
    self.chatTextField.layer.cornerRadius = 5;
    self.chatTextField.backgroundColor = [UIColor clearColor];
    self.chatTextField.delegate = self;
    
    

    
    
    if (self.type == chatTypeNormal) {
        DLOG(@"这是普通聊天区");
    }
    else if (self.type == chatTypeEmperor){
        DLOG(@"这是帝王聊天区");
    }
    else if (self.type == chatTypeSuggest){
        DLOG(@"这是建议区");
    }
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
    }];
    
    self.chatTextField.textColor = YUUYellow;
    
    WeakSelf
    _messageList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getHistoryData];
    }];
    
    _messageList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getNewData];
    }];
    
    [self readLocalMessageList];
    [self getServerMessgaeList];
    // Do any additional setup after loading the view.
}

-(void)getHistoryData{
    NSString *lastMsgId = @"0";
    NSString *refresid = @"0";
    
    if (msgArr.count > 0) {
        ChatMsgModel *lastModel = [msgArr lastObject];
        ChatMsgModel *firstModel = [msgArr firstObject];
        lastMsgId = lastModel.msgId;
        refresid = firstModel.msgId;
    }
    
    
    [self setBusyIndicatorVisible:YES];
    __weak typeof (self)weakself = self;
    YUUHappycallRequest *req  = [[YUUHappycallRequest alloc]initWithHappycall:[NSString stringWithFormat:@"%ld",(long)self.type] LastId:lastMsgId Refreshid:refresid SuccessCallback:^(YUUBaseRequest *request) {
        [weakself setBusyIndicatorVisible:NO];
        
        NSDictionary* data = [request getResponse].data;
        NSArray *addArr = data[@"msgList"];
        BOOL over = data[@"istop"];
        if (over) {
            [weakself.messageList.mj_header endRefreshing];
            [weakself.messageList.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [weakself.messageList.mj_header endRefreshing];

        }
        

        [weakself saveMessage:addArr];
        [weakself readLocalMessageList];
        [weakself.messageList reloadData];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [weakself.messageList.mj_footer endRefreshing];
        
        [weakself handleResponseError:weakself request:request needToken:YES];
        
        [weakself saveMessage:msgArr];
        [weakself.messageList reloadData];
        
    }];
    [req start];
}

-(void)getNewData{
    WeakSelf
    [self getServerMessgaeList];

}
    
- (void)getServerMessgaeList{
    NSString *lastMsgId = @"0";
    NSString *refresid = @"0";
    
    if (msgArr.count > 0) {
        ChatMsgModel *lastModel = [msgArr lastObject];
        lastMsgId = lastModel.msgId;
    }
    [self setBusyIndicatorVisible:YES];
    __weak typeof (self)weakself = self;
    YUUHappycallRequest *req  = [[YUUHappycallRequest alloc]initWithHappycall:[NSString stringWithFormat:@"%ld",(long)self.type] LastId:lastMsgId Refreshid:refresid SuccessCallback:^(YUUBaseRequest *request) {
        [weakself setBusyIndicatorVisible:NO];
        NSDictionary* data = [request getResponse].data;
        BOOL over = data[@"istop"];
        if (over) {
            [weakself.messageList.mj_footer endRefreshing];
            [weakself.messageList.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [weakself.messageList.mj_footer endRefreshing];
        }

        NSArray *addArr = data[@"msgList"];
        [weakself saveMessage:addArr];
        [weakself readLocalMessageList];
        [weakself.messageList reloadData];
        
    } failureCallback:^(YUUBaseRequest *request) {
        [self setBusyIndicatorVisible:NO];
        [weakself.messageList.mj_footer endRefreshing];

        [weakself handleResponseError:weakself request:request needToken:YES];
        
        [weakself saveMessage:msgArr];
        [weakself.messageList reloadData];

    }];
    [req start];
    
}
- (void)readLocalMessageList{
   BOOL ret = [[YUUDatabaseMgr shareInstance] openDB];
    if (ret) {
        DLOG(@"聊天表创建成功");
        msgArr = [[YUUDatabaseMgr shareInstance] queryMsg];
        [self sordTheMsg];
        [self.messageList reloadData];
    }
    else{
        DLOG(@"聊天表创建失败");
    }
}
-(void)saveMessage:(NSArray *)addArr{
    for (int i = 0; i < addArr.count; i++) {
        ChatMsgModel *m = [[ChatMsgModel alloc]initWtihDic:addArr[i]];
        BOOL ret = [[YUUDatabaseMgr shareInstance] insertData:m];
        
    }
    [self sordTheMsg];
}
-(void)sordTheMsg{
//    NSMutableArray *sortArr = [NSMutableArray arrayWithArray:msgArr];
    [msgArr sortUsingComparator:^NSComparisonResult(ChatMsgModel *obj1, ChatMsgModel *obj2) {
        return [@([obj1.msgId intValue]) compare:@([obj2.msgId intValue])];
    }];
    for (ChatMsgModel *m in msgArr) {
        NSLog(@"排序后%@",m.msgId);
    }
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return msgArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUChatMessageCell";
    YUUChatMessageCell *cell = nil;
    ChatMsgModel *m = msgArr[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.nameLabel.text = m.msgId;
    [cell setContentText:m.calltext];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(float)getSizeWithText:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = text;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    
    CGSize size = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60 - 60, 1000)];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLOG(@"indexPath=%@",indexPath);
    ChatMsgModel * m = msgArr[indexPath.row];
    
    CGFloat h = [self getSizeWithText:m.calltext] + 25;
    
    if (h < 60) {
        return 60;
    }
    else{
        return  h;
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    originInputTopMargin = self.cstTopMargin.constant;
    [self registerKeyboardNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotification];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)moveUp:(float)shift{
    self.cstTopMargin.constant -= shift;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
    
- (void)reover{
    [UIView animateWithDuration:0.2 animations:^{
        self.cstTopMargin.constant = self->originInputTopMargin;
        [self.view layoutIfNeeded];
    }];
}
    
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeView = self.chatBgView;
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
 
    [self tapCancelGesture:true];
    
}
-(void)tapCancelGesture:(bool)ret{
    if (ret) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self.view addGestureRecognizer:tap];
        self.tapCancelGesture = tap;
    }
    else{
        if (self.tapCancelGesture) {
            UITapGestureRecognizer *g = self.tapCancelGesture;
            [self.view removeGestureRecognizer:g];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self tapCancelGesture:false];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
        
    }
    return  true;
}

-(IBAction)sendMsg:(id)sender{
    if (self.chatTextField.text.length == 0) {
        [HUD showHUDTitle:@"您不能发送空" durationTime:2];
        return;
    }
    
    WeakSelf
   NSString *token = [YUUUserData shareInstance].userModel.token;
//    [self setBusyIndicatorVisible:YES];
    YUUCallNowRequest *callNow = [[YUUCallNowRequest alloc]initWithCallNow:token Callarea:[NSString stringWithFormat:@"%ld",(long)self.type] Calltext:self.chatTextField.text SuccessCallback:^(YUUBaseRequest *request) {
        [weakSelf setBusyIndicatorVisible:NO];
        [self getServerMessgaeList];
        
    } failureCallback:^(YUUBaseRequest *request) {
//        [weakSelf setBusyIndicatorVisible:NO];
        [weakSelf handleResponseError:weakSelf request:request needToken:YES];

    }];
    [callNow start];
    self.chatTextField.text = nil;

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
