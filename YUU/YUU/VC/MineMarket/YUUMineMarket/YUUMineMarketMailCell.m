//
//  YUUMineMarketMailCell.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketMailCell.h"
#import "YUUPointSellCancelRequest.h"
#import "YUUPointbuyRequest.h"
#import "YUUSellerTransactionRequest.h"
#import "YUUSellerOnsaleRequest.h"
#import "AlertController.h"
#import "YUUSuperCtrl.h"
#import "UIViewController+Help.h"

@implementation YUUMineMarketMailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = 10;
    _middleBtn.layer.borderWidth = 1;
    _middleBtn.backgroundColor = [UIColor clearColor];
    
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0.3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUPendingMailboxModel *)model {
    _model = model;
    
    _numberLabel.text = [NSString stringWithFormat:@"ID:%@",model.tradingcard];
    _timeLabel.text = model.tradingtime;
    
    _middleBtn.hidden = YES;
    _middleLeftBtn.hidden = YES;
    _middleRightBtn.hidden = YES;
    _leftBtn.hidden = YES;
    _rightBtn.hidden = YES;
    
    _middleBtn.layer.masksToBounds = YES;
    _middleBtn.layer.cornerRadius = _middleBtn.frame.size.height/2;
    _middleBtn.layer.borderWidth = 1;
    
    _middleLeftBtn.layer.masksToBounds = YES;
    _middleLeftBtn.layer.cornerRadius = _middleLeftBtn.frame.size.height/2;
    _middleLeftBtn.layer.borderWidth = 1;
    
    _middleRightBtn.layer.masksToBounds = YES;
    _middleRightBtn.layer.cornerRadius = _middleRightBtn.frame.size.height/2;
    _middleRightBtn.layer.borderWidth = 1;

    
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.layer.cornerRadius = _leftBtn.frame.size.height/2;
    _leftBtn.layer.borderWidth = 1;
    
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = _rightBtn.frame.size.height/2;
    _rightBtn.layer.borderWidth = 1;
    
    if (model.sellorbuy == 1) { // 买家
        if (model.progressnum == 1) { // 发起交易
            _middleLeftBtn.hidden = NO;
            [_middleLeftBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_middleLeftBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleLeftBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"确认交易" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"1ae08c"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"1ae08c"].CGColor;
            
            _middleRightBtn.hidden = NO;
            [_middleRightBtn setTitle:@"取消交易" forState:UIControlStateNormal];
            [_middleRightBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleRightBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"收到%ld,%ldyuu，总价%@元，请严格按照平台公布卖家资料进行打款交易，请勿相信中介！非平台公布资料交易，后果自负！",(long)model.sorbid,(long)model.coinnum, regYUUCoin([NSNumber numberWithDouble:(model.price*model.coinnum)], 2)];
        } else if (model.progressnum == 2) { // 2：买家确认了
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"收到%ld转入%ldYUU，总价%@元，等待卖方二次确认",(long)model.sorbid,(long)model.coinnum, regYUUCoin([NSNumber numberWithDouble:(model.price*model.coinnum)], 2)];
        }
    } else { // 卖家
        if (model.progressnum == 1) { // 发起交易
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"买家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"转给%ld，%ldYUU，总价%@元，等待买家确认",(long)model.sorbid,(long)model.coinnum, regYUUCoin([NSNumber numberWithDouble:(model.price*model.coinnum)], 2)];
        } else if (model.progressnum == 2) { // 卖家确认了
            _leftBtn.hidden = NO;
            [_leftBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _leftBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"确认交易" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor hex:@"1ae08c"] forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = [UIColor hex:@"1ae08c"].CGColor;
            
            _contentLabel.text = [NSString stringWithFormat:@"收到转给%ld，%ldYUU，总价%@元支付后，等待您的二次确认",(long)model.sorbid,(long)model.coinnum, regYUUCoin([NSNumber numberWithDouble:(model.price*model.coinnum)], 2)];
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"买家资料"]) {
        _hudView = [YUUSellerInfoView xibInstancetype];
        _hudView.model = _model;
        _hudView.delegate = self;
        [HUD showCustomView:_hudView];
    } else if ([title isEqualToString:@"卖家资料"]) {
        _hudView = [YUUSellerInfoView xibInstancetype];
        _hudView.model = _model;
        _hudView.delegate = self;
        [HUD showCustomView:_hudView];
    } else if ([title isEqualToString:@"确认交易"]) {
        
        if (_model.sellorbuy == 1) { // 买家
            [AlertController alertTitle:@"确认交易" message:nil determine:@"确定" cancel:@"取消" determineHandler:^
             {
                    [HUD showHUD];
                    WeakSelf
                 YUUSellerOnsaleRequest *request = [[YUUSellerOnsaleRequest alloc] initWithSellerOnsale:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
                     if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cellStatusChanged)]) {
                         [weakSelf.delegate cellStatusChanged];
                     }
                     [HUD showHUDTitle:@"确认成功" durationTime:2];
                 } failureCallback:^(YUUBaseRequest *request) {
                     [HUD hide];
                     [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
                 }];
                 
                    [request start];
             } cancelHandler:^{
                 
             }];
        } else {
            [AlertController alertTextFieldTitle:@"确认交易" message:nil determine:@"确认" cancel:@"取消" determineHandler:^(UITextField *textField) {
                if (textField.text.length != 0) {
                    [HUD showHUD];
                    WeakSelf
                    YUUSellerTransactionRequest *request = [[YUUSellerTransactionRequest alloc] initWithSellerTransaction:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard password:textField.text SuccessCallback:^(YUUBaseRequest *request) {
                          [HUD showHUDTitle:@"确认成功" durationTime:2];
                        [weakSelf performSelector:@selector(delay) withObject:nil afterDelay:2];
                      } failureCallback:^(YUUBaseRequest *request) {
                          [HUD hide];
                          [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
                      }];
                    [request start];
                }
            } cancelHandler:^{
                
            }];
        }
        
        
    } else if ([title isEqualToString:@"取消交易"]) {
        [AlertController alertTitle:@"取消交易" message:nil determine:@"确定" cancel:@"取消" determineHandler:^
         {
             [HUD showHUD];
             WeakSelf
             YUUPointSellCancelRequest *request = [[YUUPointSellCancelRequest alloc] initWithPointSellCancel:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
//                 [HUD showRequest:request];
                 [HUD showHUDTitle:@"取消成功" durationTime:2];
//                 if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cellStatusChanged)]) {
//                     [weakSelf.delegate cellStatusChanged];
//                 }
                 [weakSelf performSelector:@selector(delay) withObject:nil afterDelay:2];
             } failureCallback:^(YUUBaseRequest *request) {
//
                 [HUD hide];
                 [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];[HUD showRequest:request];
             }];
             [request start];
         } cancelHandler:^{
             
         }];
        
    }
}

- (void)delay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellStatusChanged)]) {
        [self.delegate cellStatusChanged];
    }
}

#pragma mark HUDProtocol
- (void)closeBtnDidSelected {
    [HUD hide];
}




@end
