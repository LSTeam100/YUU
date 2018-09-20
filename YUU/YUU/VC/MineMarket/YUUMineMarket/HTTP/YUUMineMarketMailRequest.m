//
//  YUUMineMarketMailRequest.m
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketMailRequest.h"

@implementation YUUMineMarketMailRequest

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    //    [self setParameters:parameters];
    [self setParameterDic:@{}];
    
    return self;
}

- (id)processResponseToModel:(NSDictionary *)dict {
    NSArray *arr = [YUUPendingMailboxModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"maildata"]];
    return arr;
}

- (NSString *)getURL {
    return @"/pointmail/";
}

@end
