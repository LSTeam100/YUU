//
//  YUUCurrencyHistoryModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCurrencyHistoryModel.h"

@implementation YUUCurrencyHistoryModel
-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.coinsite = dic[@"coinsite"];
        self.coinnum = dic[@"coinnum"];
        self.cointime = dic[@"cointime"];
    }
    return self;
}

@end

@implementation YUUCurrencyHistoryArrModel

@end
