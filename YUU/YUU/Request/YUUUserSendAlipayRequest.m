//
//  YUUUserSendAlipayRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUUserSendAlipayRequest.h"

@implementation YUUUserSendAlipayRequest
-(id)initWithSendAlipay:(NSString *)token Memberalipay:(NSString *)memberalipay SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token,memberalipay];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"memberalipay":memberalipay,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/memberalipay/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
