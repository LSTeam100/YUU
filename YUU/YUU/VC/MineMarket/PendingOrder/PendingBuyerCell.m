//
//  PendingTableViewCell.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PendingBuyerCell.h"
#import "YUUSellerSellitRequest.h"
#import "AlertController.h"
#import "YUUSuperCtrl.h"
#import "UIViewController+Help.h"

@implementation PendingBuyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_middleBtn setTitle:@"卖给TA" forState:UIControlStateNormal];
    [_middleBtn setTitleColor:[UIColor hex:@"ff2a00"] forState:UIControlStateNormal];
    
    _numberLabel.textColor = YUUYellow;
    _timeLabel.textColor = [UIColor whiteColor];
    _contentLabel.textColor = [UIColor whiteColor];
    
    _bgView.backgroundColor = [UIColor hex:@"e4c177" alpha:0.1];
}

- (void)setModel:(YUUPendingBuyerModel *)model {
    _model = model;
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = _middleBtn.frame.size.height/2;
    _middleBtn.layer.borderColor = [[UIColor hex:@"ff2a00"] CGColor];
    _middleBtn.layer.borderWidth = 1;
    
    _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
    _contentLabel.text = [NSString stringWithFormat:@"ID:%ld挂买%ldYUU,单价%ld元，总计%ld元",(long)model.memberid,(long)model.coinnum,(long)model.buyprice,(model.coinnum*model.buyprice)];
}


- (IBAction)sellAction:(id)sender {
    [AlertController alertTextFieldTitle:@"确定卖给TA" message:nil determine:@"确定" cancel:@"取消" determineHandler:^(UITextField *textField) {
        if (textField.text.length == 0) {
            return ;
        }
        WeakSelf
        [HUD showHUD];
        YUUSellerSellitRequest *request = [[YUUSellerSellitRequest alloc] initWithSellerSellit:[YUUUserData shareInstance].userModel.token Tradingcard:_model.tradingcard password:textField.text SuccessCallback:^(YUUBaseRequest *request) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(buyerCellStatusChanged)]) {
                [weakSelf.delegate buyerCellStatusChanged];
            }
//            [HUD showRequest:request];
            [HUD showHUDTitle:@"操作成功" durationTime:2];
        } failureCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD hide];
            [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
    
}



@end
