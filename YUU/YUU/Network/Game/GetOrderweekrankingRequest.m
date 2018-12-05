//
//  GetOrderweekrankingRequest.m
//  YUU
//
//  Created by boli on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GetOrderweekrankingRequest.h"

@implementation GetOrderweekrankingRequest

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{}];
    
    return self;
}


- (NSString *)getURL {
    return @"/orderweekranking/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
    NSDictionary *dict = [responseDictionary objectForKey:@"data"];
    self.getResponse.data = dict;
}

@end
