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
#import "YUUSuperCtrl.h"
#import "UIViewController+Help.h"

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
    
    [AlertController alertTextFieldTitle:@"确定卖出" message:nil determine:@"确定" cancel:@"取消" determineHandler:^(UITextField *textField) {
        if (textField.text.length == 0) {
            return ;
        }
        [HUD showHUD];
        YUUPointSellRequest *request = [[YUUPointSellRequest alloc] initWithMemberid:_idTextField.text Sellnum:_countTextField.text Sellprice:_priceTextField.text password:textField.text SuccessCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD showHUDTitle:@"卖出成功" durationTime:2];
        } failureCallback:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD hide];
            [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
        }];
        [request start];
        
        [_priceTextField resignFirstResponder];
        [_countTextField resignFirstResponder];
        _priceTextField.text = @"";
        _countTextField.text = @"";
    } cancelHandler:^{
        [_priceTextField resignFirstResponder];
        [_countTextField resignFirstResponder];
        _priceTextField.text = @"";
        _countTextField.text = @"";
    }];
    
}

- (IBAction)noticeBtnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(selectNotice)]) {
        [_delegate selectNotice];
    }
}



@end
