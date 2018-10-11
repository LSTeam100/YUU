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

@implementation PendingBuyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_middleBtn setTitle:@"卖给他" forState:UIControlStateNormal];
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
    [AlertController alertTitle:@"确定卖给他" message:nil determine:@"确定" cancel:@"取消" determineHandler:^{
        WeakSelf
        [HUD showHUD];
        YUUSellerSellitRequest *request = [[YUUSellerSellitRequest alloc] initWithSellerSellit:[YUUUserData shareInstance].userModel.token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(buyerCellStatusChanged)]) {
                [weakSelf.delegate buyerCellStatusChanged];
            }
            [HUD showRequest:request];
        } failureCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
    
}



@end
