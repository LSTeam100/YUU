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
        self.milltype = [dic[@"milltype"] integerValue];
        self.runtimeday = dic[@"runtimeday"];
        self.totaldays = dic[@"totaldays"];
        self.compower = dic[@"compower"];
        self.outputcoins = dic[@"outputcoins"];
        self.getmill = [dic[@"getmill"] integerValue];
        self.milldie = [dic[@"milldie"] integerValue];
    }
    return self;
}

- (NSString *)milltypeName {
    switch (_milltype) {
        case YUUMilltypeNovice:
            return @"新手";
            break;
        case YUUMilltypebronze:
            return @"青铜";
            break;
        case YUUMilltypesilver:
            return @"白银";
            break;
        case YUUMilltypegold:
            return @"黄金";
            break;
        case YUUMilltypePlatinum:
            return @"铂金";
            break;
        case YUUMilltypediamond:
            return @"钻石";
            break;
            
        default:
            return @"新手";
            break;
    }
}

@end

@implementation YUUMachineArrModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"msgList" : @"YUUMachineDetailModel"};
}

@end





