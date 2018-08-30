//
//  YUUMachineArrModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMachineArrModel.h"


@implementation YUUMachineDetailModel
-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.millsize = dic[@"millsize"];
        self.milltype = dic[@"milltype"];
        self.runtimeday = dic[@"runtimeday"];
        self.totaldays = dic[@"totaldays"];
        self.compower = dic[@"compower"];
        self.outputcoins = dic[@"outputcoins"];
        self.getmill = dic[@"getmill"];
        self.milldie = dic[@"milldie"];
    }
    return self;
}
@end

@implementation YUUMachineArrModel

@end





