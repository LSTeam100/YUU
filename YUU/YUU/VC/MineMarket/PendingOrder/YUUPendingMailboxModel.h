//
//  YUUPendingMailboxModel.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface YUUPendingMailboxModel : YUUBaseModel

@property (nonatomic, assign) NSInteger sorbid; // 卖家或买家ID

@property (nonatomic, assign) NSInteger progressnum; // 进展值（1：发起交易 2：买家确认了 3：卖家确认了）

@property (nonatomic, assign) NSInteger coinnum; // 币数coinnum

@property (nonatomic, strong) NSString *tradingtime; // 单号时间

@property (nonatomic, strong) NSString *tradingcard; // 单号

@property (nonatomic, strong) NSString *membername; // 身份证名字

@property (nonatomic, strong) NSString *bankname; // 开户行

@property (nonatomic, strong) NSString *bankcard; // 帐号

@property (nonatomic, strong) NSString *memberwx; // 微信号

@property (nonatomic, strong) NSString *memberalipay; // 支付宝号

@property (nonatomic, strong) NSString *memberphone; // 手机号（Int）

@property (nonatomic, strong) NSString *memberwallet; // 虚拟钱包即冷钱包

@property (nonatomic, assign) NSInteger sellorbuy; // 卖家0，买家1

@property (nonatomic, assign) double price;


@property (nonatomic, assign) long buynum;
@property (nonatomic, assign) double buyprice;


@end
