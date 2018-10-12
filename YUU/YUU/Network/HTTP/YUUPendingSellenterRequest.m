//
//  YUUPendingSellenterRequest.m
//  YUU
//
//  Created by boli on 2018/10/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingSellenterRequest.h"

@implementation YUUPendingSellenterRequest

- (instancetype)initWithTradingcard:(NSString *)tradingcard
                           password:(NSString *)password
                          success:(onSuccessCallback)success
                          failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"tradingcard" : tradingcard,
                            @"tradepsw" : [YUUEncryMgr sha1:password]
                            }];
    
//    NSArray *signArr = @[sellnum,memberid,priceKey,[YUUUserData shareInstance].token, [YUUEncryMgr sha1:password]];
//    NSString *sha1key = getSignFromParameter(signArr);
//
//    NSDictionary *parameters=@{
//                               @"sellnum" : sellnum,
//                               @"memberid" : memberid,
//                               @"sellprice" : sellprice,
//                               @"token" : [YUUUserData shareInstance].token,
//                               @"sign" : sha1key,
//                               @"tradepsw" : [YUUEncryMgr sha1:password]
//                               };
//    [self setParameters:parameters];
    
    return self;
}


- (NSString *)getURL {
    return @"/sellenter/";
}

@end
