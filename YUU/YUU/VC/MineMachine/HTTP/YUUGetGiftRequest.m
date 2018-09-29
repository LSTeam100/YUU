//
//  YUUGetGiftRequest.m
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUGetGiftRequest.h"

@implementation YUUGetGiftRequest

- (instancetype)initWithMillid:(NSString *)millid
                        uccess:(onSuccessCallback)success
                        failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    
    NSDictionary *parameters = @{ @"millid" : millid };
    [self setParameterDic:parameters];
    
    return self;
}

- (NSString *)getURL {
    return @"/getgiftmill/";
}



@end
