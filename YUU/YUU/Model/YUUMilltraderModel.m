//
//  YUUMilltraderModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMilltraderModel.h"

@implementation YUUMilltraderModel
-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.compower = dic[@"compower"];
        self.totaldays = dic[@"totaldays"];
        self.totalcoins = dic[@"totalcoins"];
        self.millprice = dic[@"millprice"];
        self.milltype = dic[@"milltype"];
    }
    return self;
}

@end


@implementation YUUMilltraderArrModel

@end
