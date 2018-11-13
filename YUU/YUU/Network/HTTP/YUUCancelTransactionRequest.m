//
//  YUUCancelTransactionRequest.m
//  YUU
//
//  Created by boli on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUCancelTransactionRequest.h"

@implementation YUUCancelTransactionRequest

- (instancetype)initWithTradingcard:(NSString *)tradingcard
                            success:(onSuccessCallback)success
                            failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"tradingcard" : tradingcard
                            }];
    
    return self;
}


- (NSString *)getURL {
    return @"/canceluporder/";
}

@end
