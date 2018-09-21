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
#import "YUUSellerInfoView.h"
#import "YUUBuyerTransactionRequest.h"

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
            [_leftBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_leftBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _leftBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
            
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"确认交易" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"1ae08c"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"1ae08c"].CGColor;
            
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"取消交易" forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _rightBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
        } else if (model.progressnum == 2) { // 2：买家确认了
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
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
        } else if (model.progressnum == 3) { // 卖家确认了
            _middleBtn.hidden = NO;
            [_middleBtn setTitle:@"卖家资料" forState:UIControlStateNormal];
            [_middleBtn setTitleColor:[UIColor hex:@"00baff"] forState:UIControlStateNormal];
            _middleBtn.layer.borderColor = [UIColor hex:@"00baff"].CGColor;
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"买家资料"]) {
        YUUSellerInfoView *hudView = [YUUSellerInfoView xibInstancetype];
        hudView.model = _model;
        [HUD showCustomView:hudView];
    } else if ([title isEqualToString:@"卖家资料"]) {
        YUUSellerInfoView *hudView = [YUUSellerInfoView xibInstancetype];
        hudView.model = _model;
        [HUD showCustomView:hudView];
    } else if ([title isEqualToString:@"确认交易"]) {
        if (_model.sellorbuy == 1) { // 买家
            YUUBuyerTransactionRequest *request = [[YUUBuyerTransactionRequest alloc] initWithBuyerTransaction:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
                
            } failureCallback:^(YUUBaseRequest *request) {
                
            }];
            [request start];
        } else {
            YUUSellerOnsaleRequest *request = [[YUUSellerOnsaleRequest alloc] initWithSellerOnsale:[YUUUserData shareInstance].token Tradingcard:_model.tradingcard SuccessCallback:^(YUUBaseRequest *request) {
                
            } failureCallback:^(YUUBaseRequest *request) {
                
            }];
            [request start];
        }
    } else if ([title isEqualToString:@"取消交易"]) {
        YUUPointSellCancelRequest *request = [[YUUPointSellCancelRequest alloc] initWithPointSellCancel:[YUUUserData shareInstance].token Tradingcard:@"" SuccessCallback:^(YUUBaseRequest *request) {
            
        } failureCallback:^(YUUBaseRequest *request) {
            
        }];
        [request start];
    }
}






@end
