//
//  PendingMailboxCell.m
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PendingMailboxCell.h"
#import "YUUBuyerTransactionRequest.h"
#import "YUUSellerOnsaleRequest.h"

@implementation PendingMailboxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_middleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _numberLabel.textColor = YUUYellow;
    _timeLabel.textColor = [UIColor whiteColor];
    _contentLabel.textColor = [UIColor whiteColor];
    
    _bgView.backgroundColor = [UIColor hex:@"e4c177" alpha:0.1];
}

- (void)setModel:(YUUPendingMailboxModel *)model {
    _model = model;
    
    _middleBtn.hidden = YES;
    _leftBtn.hidden = YES;
    _rightBtn.hidden = YES;
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = _middleBtn.frame.size.height/2;
    _middleBtn.layer.borderWidth = 1;
    
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.layer.cornerRadius = _leftBtn.frame.size.height/2;
    _leftBtn.layer.borderWidth = 1;
    
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = _rightBtn.frame.size.height/2;
    _rightBtn.layer.borderWidth = 1;
    
    if (model.sellorbuy == 1) { // 买家
        if (model.progressnum == 1) { // 发起交易
            _leftBtn.hidden = NO;
            [_leftBtn setTitle:@"买家资料" forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _leftBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"确认交易" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor hex:@"1ae08c"] forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = [UIColor hex:@"1ae08c"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"收到%ld的支付后，等待卖家的二次确认",(long)model.sorbid];
        } else if (model.progressnum == 2) { // 2：买家确认了
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"买家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"给%ld转入%ldYUU，等待买家确认",(long)model.sorbid,(long)model.coinnum];
        }
    } else {
        if (model.progressnum == 1) { // 发起交易
            _leftBtn.hidden = NO;
            [_leftBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _leftBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"确认交易" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor hex:@"1ae08c"] forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = [UIColor hex:@"1ae08c"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"收到%ld转入的%ldYUU，请严格按照平台公布的卖/买家资料进行交易，请勿相信中介！非平台公布资料交易，后果自负",(long)model.sorbid,(long)model.coinnum];
        } else if (model.progressnum == 3) { // 卖家确认了
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"支付%ldYUU的交易款后，等待卖家的确认",(long)model.coinnum];
        }
    }
    
    
    
    _numberLabel.text = [NSString stringWithFormat:@"单号：%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
}

- (void)btnAction:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"确认"]) {
        if (_model.sellorbuy == 1) { // 买家
            [HUD showHUD];
            WeakSelf
            YUUBuyerTransactionRequest *request = [[YUUBuyerTransactionRequest alloc] initWithBuyerTransaction:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cellStatusChanged)]) {
                    [weakSelf.delegate cellStatusChanged];
                }
                [HUD showRequest:request];
            } failureCallback:^(YUUBaseRequest *request) {
                [HUD showRequest:request];
            }];
            [request start];
        } else {
            [HUD showHUD];
            WeakSelf
            YUUSellerOnsaleRequest *request = [[YUUSellerOnsaleRequest alloc] initWithSellerOnsale:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cellStatusChanged)]) {
                    [weakSelf.delegate cellStatusChanged];
                }
                [HUD showRequest:request];
            } failureCallback:^(YUUBaseRequest *request) {
                [HUD showRequest:request];
            }];
            [request start];
        }
    } else if ([btn.titleLabel.text isEqualToString:@"买家资料"]) {
        YUUSellerInfoView *hudView = [YUUSellerInfoView xibInstancetype];
        hudView.model = _model;
        hudView.delegate = self;
        [HUD showCustomView:hudView];
    } else if ([btn.titleLabel.text isEqualToString:@"卖家资料"]) {
        YUUSellerInfoView *hudView = [YUUSellerInfoView xibInstancetype];
        hudView.model = _model;
        hudView.delegate = self;
        [HUD showCustomView:hudView];
    }
}

- (void)closeBtnDidSelected {
    [HUD hide];
}

@end
