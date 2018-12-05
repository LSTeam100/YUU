//
//  GetAttackorderRequest.m
//  YUU
//
//  Created by boli on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GetAttackorderRequest.h"

@implementation GetAttackorderRequest

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{}];
    
    return self;
}


- (NSString *)getURL {
    return @"/attackorder/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
    NSDictionary *dict = [responseDictionary objectForKey:@"data"];
    self.getResponse.data = [dict objectForKey:@"newnews"];
}

@end
