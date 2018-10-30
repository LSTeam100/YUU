//
//  YUUPendingBuyerModel.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface YUUPendingBuyerModel : YUUBaseModel

@property (nonatomic, strong) NSString *tradingcard; // 单号

@property (nonatomic, strong) NSString *tradingtime; // 单号时间

@property (nonatomic, assign) NSInteger memberid; // 买家ID（Int）
@property (nonatomic, strong) NSString *memberidStr;

@property (nonatomic, assign) NSInteger coinnum; // 币数（Int）

@property (nonatomic, assign) double buyprice; // 买价（Double）

@end
