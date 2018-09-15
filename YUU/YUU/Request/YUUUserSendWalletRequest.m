//
//  YUUUserSendWalletRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUUserSendWalletRequest.h"

@implementation YUUUserSendWalletRequest
-(id)initWithSendWallet:(NSString *)token Memberwallet:(NSString *)memberwallet SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token,memberwallet];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"memberwallet":memberwallet,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/memberwallet/";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
