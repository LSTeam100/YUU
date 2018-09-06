//
//  YUUGetPendingMailRequest.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUGetPendingMailRequest.h"

@implementation YUUGetPendingMailRequest

- (instancetype)initWithUserLevel:(UserLevel)level
                          success:(onSuccessCallback)success
                          failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    
    NSDictionary *parameters=@{ @"uporderstype": [NSNumber numberWithInteger:level] };
    [self setParameters:parameters];
    
    [self start];
    
    return self;
}

- (id)processResponseToModel:(NSDictionary *)dict {
    NSArray *arr = [YUUPendingMailboxModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"maildata"]];
    return arr;
}

- (NSString *)getURL {
    return @"/upordermail/";
}

@end
