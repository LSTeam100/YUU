//
//  GetMinePoolRequest.m
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GetMineralPoolRequest.h"

@implementation GetMineralPoolRequest

- (instancetype)initWithSuccess:(onSuccessCallback)success
                        failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    
    NSDictionary *parameters = @{  };
    [self setParameters:parameters];
    
    return self;
}

- (NSString *)getURL {
    return @"/millspool/";
}

- (id)processResponseToModel:(NSDictionary *)dict {
    return [MineralPoolModel mj_objectWithKeyValues:dict];
}

@end
