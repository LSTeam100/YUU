//
//  MineralPoolModel.m
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineralPoolModel.h"

@implementation MineralPoolModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"directid": @"DirectPushModel",
             @"nodirectid": @"TeamPushModel"
             };
}

@end
