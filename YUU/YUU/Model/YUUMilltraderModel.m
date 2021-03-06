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
        self.milltype = [dic[@"milltype"] integerValue];
    }
    return self;
}


- (NSString *)typeName {
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

- (NSString *)iconName {
    return [NSString stringWithFormat:@"miningMachine%ld",_milltype];
    switch (_milltype) {
        case YUUMilltypeNovice:
            return @"miningMachine0";
            break;
        case YUUMilltypebronze:
            return @"miningMachine1";
            break;
        case YUUMilltypesilver:
            return @"miningMachine2";
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


@implementation YUUMilltraderArrModel

@end
