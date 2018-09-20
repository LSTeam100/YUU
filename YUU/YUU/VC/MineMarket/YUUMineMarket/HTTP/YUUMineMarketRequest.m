//
//  YUUMineMarketRequest.m
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketRequest.h"

@implementation YUUMineMarketRequest

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
//    [self setParameters:parameters];
    [self setParameterDic:@{}];
    
    return self;
}

- (id)processResponseToModel:(NSDictionary *)dict {
    YUUPriceModel *model = [YUUPriceModel mj_objectWithKeyValues:dict];
    return model;
}

- (NSString *)getURL {
    return @"/milltrader/";
}

@end
