//
//  WarbackRequest.m
//  YUU
//
//  Created by boli on 2018/12/4.
//  Copyright © 2018 apple. All rights reserved.
//

#import "WarbackRequest.h"

@implementation WarbackRequest

- (instancetype)initBattlenum:(NSString *)battlenum
                    success:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"battlenum":battlenum}];
    
    return self;
}


- (NSString *)getURL {
    return @"/warback/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
}

@end
