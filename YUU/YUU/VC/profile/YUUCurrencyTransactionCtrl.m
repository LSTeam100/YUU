//
//  YUUCurrencyTransactionCtrl.m
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCurrencyTransactionCtrl.h"
#import "YUUTransactionHistoryCtrl.h"
#import "YUUCurrencySellRequest.h"
#import "HUD.h"
#import "YUUUserData.h"
#import "AlertController.h"

@implementation YUUCurrencyCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bottomView.backgroundColor = colorWithHexString(@"e4c177", 1.0);
    self.titleLabel.textColor = colorWithHexString(@"e4c177", 1.0);


}

@end


@interface YUUCurrencyTransactionCtrl ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    CGFloat originInputTopMargin;

}
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIButton *leftSelectBtn;
@property(nonatomic,weak)IBOutlet UIButton *rightSelectBtn;
@property(nonatomic,weak)IBOutlet UILabel *coinsiteLabel;
@property(nonatomic,weak)IBOutlet UILabel *coinnumLabel;
@property(nonatomic,weak)IBOutlet UITextField *coinsiteField;
@property(nonatomic,weak)IBOutlet UITextField *coinnumField;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *cstTopMargin;
@property(nonatomic,weak)IBOutlet UIButton *sellBtn;
@property(nonatomic,weak)UITapGestureRecognizer *tapCancelGesture;
@property(nonatomic,weak)IBOutlet UILabel *avaliableLabel;
@property(nonatomic,weak)IBOutlet UILabel *alertLabel;
@property(nonatomic,weak)IBOutlet UIView *addressView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint *topConstant;
@property(nonatomic,weak)IBOutlet UIView *moneyView;
@end

@implementation YUUCurrencyTransactionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"币币交易";
    self.tableView.backgroundColor = [UIColor clearColor];
    [self initSegmentBar];
    [self setCustomBackItem];
    
//    float money = [self.avalibleMoney floatValue];
    self.avaliableLabel.text = regYUUCoin(self.avalibleMoney, 6);
    
    
    
    self.avaliableLabel.textColor = colorWithHexString(@"ED6621", 1);
    UIBarButtonItem *histroyItem = [[UIBarButtonItem alloc]initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(naviToHistoryController)];
    
    self.navigationItem.rightBarButtonItem = histroyItem;
    [self.navigationItem.rightBarButtonItem setTintColor:colorWithHexString(@"e4c177", 1.0)];
    
    
    self.coinnumLabel.textColor = colorWithHexString(@"e4c177", 1.0);
    self.coinsiteLabel.textColor = colorWithHexString(@"e4c177", 1.0);
    self.coinsiteLabel.text = @"钱包地址";
    self.coinnumLabel.text = @"YUU数量";

    self.coinsiteField.placeholder = @"请输入地址";
    self.coinnumField.placeholder = @"请输入交易金额";
    
    self.coinsiteField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.coinsiteField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    self.coinnumField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.coinnumField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        DLOG(@"text change");
    }];

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
        self.addressView.hidden = false;
        self.sellBtn.hidden = false;
        self.moneyView.hidden = false;
        self.topConstant.constant = 56;
        self.alertLabel.text = @"警告：此功能是将YUU转换成外埠平台代币，兑换比例锚定为1:1兑换，不能内部转账，否则会导致YUU丢失无法找回，平台地址一定要填写正确，否者导致兑换错误由用户自己承担。兑换地址为交易所IDAX交易所钱包地址。";
    }
    else{
        [self.leftSelectBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.rightSelectBtn setBackgroundImage:[UIImage imageNamed:@"btn_right_selected"] forState:UIControlStateNormal];
        self.addressView.hidden = true;
        self.sellBtn.hidden = true;
        self.moneyView.hidden = true;
        self.topConstant.constant = -150;

        self.alertLabel.text = @"尊贵的朋友，您好，我们的转入功能正在开发中，如需交易所兑换YUU，请加官方客服1微信号或官方客服1QQ号进行兑换（官方客服1微信号：LWP20020701或官方客服1QQ号：2878748834）";

    }
    
}
-(IBAction)sell:(id)sender{
    
    
    if (self.coinsiteField.text.length == 0) {
        [HUD showHUDTitle:@"地址不能为空" durationTime:2];
        return;
    }

    if (self.coinnumField.text.length == 0) {
        [HUD showHUDTitle:@"交易金额不能为空" durationTime:2];
        return;
    }
    
    [AlertController alertTextFieldTitle:@"交易确认" message:nil determine:@"确定" cancel:@"取消" determineHandler:^(UITextField *textField)
    {
        if (textField.text.length == 0) {
            return ;
        }
        [self setBusyIndicatorVisible:YES];
        NSString *token = [YUUUserData shareInstance].userModel.token;
        WeakSelf
        YUUCurrencySellRequest *sell = [[YUUCurrencySellRequest alloc]initWithCurrencySell:token Coinsite:self.coinsiteField.text Coinnum:self.coinnumField.text password:textField.text SuccessCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
            [HUD showHUDTitle:@"转出成功" durationTime:2];
            
            
        } failureCallback:^(YUUBaseRequest *request) {
            [self setBusyIndicatorVisible:NO];
//            YUUResponse *res = [request getResponse];
//            switch (res.code) {
//                case 0:
//                DLOG(@"用户错误信息");
//                    [HUD showHUDTitle:res.msg durationTime:2];
//
//                break;
//                case 1:
//                DLOG(@"token无效");
//                break;
//                case 3:
//                DLOG(@"闭市");
//                    showCostomAlert(@"closeMarket_alert", weakSelf.view.frame);
//
//                break;
//                default:
//                    [HUD showHUDTitle:res.msg durationTime:2];
//
//                break;
//            }
            
            [weakSelf handleResponseError:weakSelf request:request needToken:YES];
        }];
        [sell start];
    } cancelHandler:^{
        
    }];
    
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"钱包地址";
            cell.field.placeholder = @"请输入钱包地址";

            break;
        case 1:
            cell.titleLabel.text = @"YUU数量";
            cell.field.placeholder = @"请输入需要转出的YUU钱币数量";
            break;
        default:
            break;
    }
    cell.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:cell.field.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    return cell;
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
    self.activeView = textField;
    if (textField == self.coinnumField) {
        self.activeView = self.sellBtn;
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    originInputTopMargin = self.cstTopMargin.constant;
    [self registerKeyboardNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self unregisterKeyboardNotification];
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
