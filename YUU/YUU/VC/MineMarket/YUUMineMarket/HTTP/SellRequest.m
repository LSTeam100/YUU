//
//  SellRequest.m
//  YUU
//
//  Created by boli on 2018/10/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SellRequest.h"

@implementation SellRequest

- (instancetype)initWithMemberid:(NSString *)memberid
                         Sellnum:(NSString *)sellnum
                       Sellprice:(NSString *)sellprice
                         Success:(onSuccessCallback)success
                         failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    
    [self setParameterDic:@{@"memberid":memberid,
                            @"sellnum":sellnum,
                            @"sellprice":sellprice,
                            }];
    
    return self;
}

- (id)processResponseToModel:(NSDictionary *)dict {
    YUUPointSellModel *model = [YUUPointSellModel mj_objectWithKeyValues:dict];
    return model;
}

- (NSString *)getURL {
    return @"/pointsell/";
}

@end
