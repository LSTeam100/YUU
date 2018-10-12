//
//  YUUCurrencySellRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCurrencySellRequest.h"
#import "YUUEncryMgr.h"

@implementation YUUCurrencySellRequest
-(id)initWithCurrencySell:(NSString *)token Coinsite:(NSString *)coinsite Coinnum:(NSString *)coinnum password:(NSString *)password SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token,coinsite,coinnum,[YUUEncryMgr sha1:password]];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"coinsite":coinsite,
                                   @"coinnum":coinnum,
                                   @"sign" : sha1key,
                                   @"tradepsw" : [YUUEncryMgr sha1:password]
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/cointrader/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
