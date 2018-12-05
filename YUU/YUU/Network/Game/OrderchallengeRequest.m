//
//  OrderchallengeRequest.m
//  YUU
//
//  Created by boli on 2018/12/4.
//  Copyright © 2018 apple. All rights reserved.
//

#import "OrderchallengeRequest.h"

@implementation OrderchallengeRequest

- (instancetype)initBattlenum:(NSString *)battlenum
                      success:(onSuccessCallback)success
                      failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"battlenum":battlenum}];
    
    return self;
}


- (NSString *)getURL {
    return @"/orderchallenge/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
}

@end
