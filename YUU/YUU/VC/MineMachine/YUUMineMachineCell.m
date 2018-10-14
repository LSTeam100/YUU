//
//  YUUMineMachineCell.m
//  YUU
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMachineCell.h"
#import "YUUGetGiftRequest.h"
#import "UIViewController+Help.h"
#import "YUUSuperCtrl.h"

@implementation YUUMineMachineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receiveAction:)];
    [_receiveLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(YUUMachineDetailModel *)model {
    _model = model;
    
    _statusView.layer.masksToBounds = YES;
    _statusView.layer.cornerRadius = _statusView.frame.size.width/2;
    _numberLabel.text = model.millsize;
    _typeLabel.text = [_model.milltype stringByReplacingOccurrencesOfString:@"矿机" withString:@""];
    _operationLabel.text = [NSString stringWithFormat:@"%ld/%ld",[model.runtimeday integerValue], [model.totaldays integerValue]];
    _powerLabel.text = [NSString stringWithFormat:@"%ld", [model.compower integerValue]];
    _outputLabel.text = [NSString stringWithFormat:@"%.2f", [model.outputcoins doubleValue]];
    
    if (model.getmill == YUUMachineReceiveNo) {
        _receiveLabel.text = @"未领取";
    }
    else if (model.getmill == YUUMachineReceiveDefault)
    {
        _receiveLabel.text = @"";
    }
    else if(model.getmill == YUUMachineReceived) {
        _receiveLabel.text = @"已领取";
    }
    else{
        _receiveLabel.text = @"已领取";

    }
}
- (IBAction)receiveAction:(UITapGestureRecognizer *)sender {
    if (_model.getmill == YUUMachineReceiveNo) {
        [HUD showHUD];
        WeakSelf
        YUUGetGiftRequest *request = [[YUUGetGiftRequest alloc] initWithMillid:_model.millsize uccess:^(YUUBaseRequest *request) {
            weakSelf.model.getmill = YUUMachineReceived;
            weakSelf.receiveLabel.text = @"已领取";
//            [HUD showRequest:request];
            [HUD showHUDTitle:@"领取成功" durationTime:2];
        } failure:^(YUUBaseRequest *request) {
//            [HUD showRequest:request];
            [HUD hide];
            [(YUUSuperCtrl *)[UIViewController currentViewController] handleResponseError:(YUUSuperCtrl *)[UIViewController currentViewController] request:request needToken:YES];
        }];
        [request start];
    }
}


@end
