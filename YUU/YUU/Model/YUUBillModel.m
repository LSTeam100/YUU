//
//  YUUBillModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBillModel.h"

@implementation YUUBillModel

-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.billname = dic[@"billname"];
        self.billnum = dic[@"billnum"];
        self.billtime = dic[@"billtime"];
        self.billtype = dic[@"billtype"];
    }
    return self;
}

@end

@implementation YUUBillModelList
-(instancetype)init{
    self = [super init];
    if (self) {
        self.billModelArr = [[NSMutableArray alloc]init];
    }
    return self;
    
}
@end
