//
//  YUUChatCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatCtrl.h"
#import "YUUChatMessageCell.h"
@interface YUUChatCtrl ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat originInputTopMargin;

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

    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"YUUChatMessageCell";
    YUUChatMessageCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    [cell setContentText:@"你是一款两件事看来大家反馈就是打开圣诞快乐放假快乐圣诞节福利开始江东父老会计师看来大家反馈脸上的肌肤立刻就是考虑到肌肤立刻升级到了放假了是肯德基风口浪尖"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(float)getSizeWithText:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = text;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    
    CGSize size = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60 - 53, 1000)];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLOG(@"indexPath=%@",indexPath);
   return  [self getSizeWithText:@"你是一款两件事看来大家反馈就是打开圣诞快乐放假快乐圣诞节福利开始江东父老会计师看来大家反馈脸上的肌肤立刻就是考虑到肌肤立刻升级到了放假了是肯德基风口浪尖"] +30;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
