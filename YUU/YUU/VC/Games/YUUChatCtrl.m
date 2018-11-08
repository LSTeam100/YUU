//
//  YUUChatCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatCtrl.h"
#import "YUUChatMessageCell.h"
@interface YUUChatCtrl ()<UITableViewDelegate,UITableViewDataSource>
    @property (weak, nonatomic) IBOutlet UIView *chatBgView;
    @property (weak, nonatomic) IBOutlet UIView *chatBottomView;
    @property (weak, nonatomic) IBOutlet UITextField *chatTextField;
    @property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;
    @property (weak, nonatomic) IBOutlet UITableView *messageList;
    
@end

@implementation YUUChatCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"畅所欲言";
    self.chatBgView.layer.borderWidth = 1.0;
    self.chatBgView.layer.borderColor = YUUYellow.CGColor;
    self.chatBgView.backgroundColor = [UIColor clearColor];
    if (self.type == chatTypeNormal) {
        DLOG(@"这是普通聊天区");
    }
    else if (self.type == chatTypeEmperor){
        DLOG(@"这是帝王聊天区");
    }
    else if (self.type == chatTypeSuggest){
        DLOG(@"这是建议区");
    }
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
    
    CGSize size = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60 - 10, 1000)];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    return size.height;
}
    
-(void)addMessgaeLabel:(YUUChatMessageCell *)cell{

//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(cell.nameLabel.frame.origin.x,CGRectGetMaxY(cell.nameLabel.frame),cell.contentView.frame.size.width - cell.nameLabel.frame.origin.x - 10, 60)];
//    bgView.backgroundColor = [UIColor clearColor];
//
//    UILabel *adTag = [[UILabel alloc] initWithFrame:bgView.bounds];
//    [bgView addSubview:adTag];
//    adTag.font = [UIFont systemFontOfSize:14];
//    adTag.textColor = YUUYellow;
//    adTag.textAlignment = NSTextAlignmentLeft;
//
//    CALayer *mask = [CALayer layer];
//    mask.opacity = 1.0;
//    mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor;
//    mask.cornerRadius = 10;;
//    mask.masksToBounds = YES;
//    mask.frame = CGRectMake(0, 0, 100, 100);

//    bgView.layer.mask = mask;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLOG(@"indexPath=%@",indexPath);
   return  [self getSizeWithText:@"你是一款两件事看来大家反馈就是打开圣诞快乐放假快乐圣诞节福利开始江东父老会计师看来大家反馈脸上的肌肤立刻就是考虑到肌肤立刻升级到了放假了是肯德基风口浪尖"] +30;
    
//    return  60;
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
