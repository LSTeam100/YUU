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
    _middleBtn.layer.borderWidth = 1;
    
    
    if (model.memberid == [[YUUUserData shareInstance].userModel.memberid integerValue]) {
        _middleBtn.layer.borderColor = [[UIColor hex:@"a8a296"] CGColor];
        [_middleBtn setTitleColor:[UIColor hex:@"a8a296"] forState:UIControlStateNormal];
        _middleBtn.userInteractionEnabled = NO;
    } else {
        _middleBtn.layer.borderColor = [[UIColor hex:@"ff2a00"] CGColor];
        [_middleBtn setTitleColor:[UIColor hex:@"ff2a00"] forState:UIControlStateNormal];
        _middleBtn.userInteractionEnabled = YES;
    }
    
    _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
    if (_level == UserLevelInternational) {
        _contentLabel.text = [NSString stringWithFormat:@"ID:%@挂买%ldYUU,单价%@ETH，总计%@ETH",model.memberidStr,(long)model.coinnum,regYUUCoin([NSNumber numberWithDouble:model.buyprice], 4),regYUUCoin([NSNumber numberWithDouble:(model.coinnum*model.buyprice)], 4)];
    } else {
        _contentLabel.text = [NSString stringWithFormat:@"ID:%@挂买%ldYUU,单价%@元，总计%@元",model.memberidStr,(long)model.coinnum,regYUUCoin([NSNumber numberWithDouble:model.buyprice], 2),regYUUCoin([NSNumber numberWithDouble:(model.coinnum*model.buyprice)], 2)];
    }
    
}


- (IBAction)sellAction:(id)sender {
    [AlertController alertTextFieldTitle:@"确定卖给TA" message:nil determine:@"确定" cancel:@"取消" determineHandler:^(UITextField *textField) {
        if (textField.text.length == 0) {
            return ;
        }
        WeakSelf
        [HUD showHUD];
        YUUSellerSellitRequest *request = [[YUUSellerSellitRequest alloc] initWithSellerSellit:[YUUUserData shareInstance].userModel.token Tradingcard:_model.tradingcard password:textField.text SuccessCallback:^(YUUBaseRequest *request) {
            
//            [HUD showRequest:request];
            [HUD showHUDTitle:@"操作成功" durationTime:2];
            [weakSelf performSelector:@selector(delay) withObject:nil afterDelay:2];
        } failureCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD hide];
            [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
    
}

- (void)delay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyerCellStatusChanged)]) {
        [self.delegate buyerCellStatusChanged];
    }
}


@end
