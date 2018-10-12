//
//  YUUMineMarketPointCell.m
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketPointCell.h"
#import "UITextField+Help.h"
#import "YUUPointSellRequest.h"
#import "Header.h"
#import "SellRequest.h"
#import "AlertController.h"

@implementation YUUMineMarketPointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_noticeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_noticeBtn setTitle:@"点对点交易须知" forState:UIControlStateNormal];
    
    [_idTextField setPlaceholderColor:[UIColor whiteColor]];
    [_countTextField setPlaceholderColor:[UIColor whiteColor]];
    [_priceTextField setPlaceholderColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sellBtnAction:(UIButton *)sender {
    if (_idTextField.text.length == 0 ||
        _priceTextField.text.length == 0 ||
        _countTextField.text.length == 0) {
        return;
    }
    [AlertController alertTitle:@"确定卖出" message:nil determine:@"确定" cancel:@"取消" determineHandler:^{
        [HUD showHUD];
        YUUPointSellRequest *request = [[YUUPointSellRequest alloc] initWithMemberid:_idTextField.text Sellnum:_countTextField.text Sellprice:_priceTextField.text SuccessCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        } failureCallback:^(YUUBaseRequest *request) {
            [HUD showRequest:request];
        }];
        [request start];
    } cancelHandler:^{
        
    }];
    
}

- (IBAction)noticeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(selectNotice)]) {
        [_delegate selectNotice];
    }
}



@end
