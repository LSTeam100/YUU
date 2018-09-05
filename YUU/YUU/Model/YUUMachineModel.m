//
//  YUUMachineModel.m
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "YUUMachineModel.h"

@implementation YUUMachineModel

- (NSString *)typeName {
    switch (_type) {
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
