//
//  YUUMachinePoolArrModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMachinePoolArrModel.h"


@implementation YUUMachinePoolModel
-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.headphoto = dic[@"headphoto"];
        self.membergrade = dic[@"membergrade"];
        self.memberid = dic[@"memberid"];
        self.memberpower = dic[@"memberpower"];
        self.membertotalmills = dic[@"membertotalmills"];
        self.membertotaldirect = dic[@"membertotaldirect"];
        self.membertotalnodirect = dic[@"membertotalnodirect"];
        self.memberphone = dic[@"memberphone"];
    }
    return self;
}
@end

@implementation YUUMachinePoolArrModel

@end
