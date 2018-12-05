//
//  GetAllRankRequest.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GetAllRankRequest.h"

@implementation GetAllRankRequest

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{}];
    
    return self;
}


- (NSString *)getURL {
    return @"/ordertotalranking/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
    NSDictionary *dict = [responseDictionary objectForKey:@"data"];
    self.getResponse.data = dict;
}

@end
