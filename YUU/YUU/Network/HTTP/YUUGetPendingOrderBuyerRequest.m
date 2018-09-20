//
//  YUUGetPendingOrderBuyerRequest.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUGetPendingOrderBuyerRequest.h"

@implementation YUUGetPendingOrderBuyerRequest

- (instancetype)initWithUserLevel:(UserLevel)level
                          success:(onSuccessCallback)success
                          failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    
    NSDictionary *parameters=@{ @"uporderstype": [NSNumber numberWithInteger:level] };
//    [self setParameters:parameters];
    [self setParameterDic:parameters];
    
    return self;
}

- (id)processResponseToModel:(NSDictionary *)dict {
    NSArray *arr = [YUUPendingBuyerModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"buylist"]];
    return arr;
}

- (NSString *)getURL {
    return @"/sellrecord/";
}



@end
