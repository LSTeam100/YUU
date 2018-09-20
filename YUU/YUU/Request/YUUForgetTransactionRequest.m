//
//  YUUForgetTransactionRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUForgetTransactionRequest.h"

@implementation YUUForgetTransactionRequest
-(id)initWithForgetTransaction:(NSString *)token Memberphone:(NSString *)memberphone Newtraderpsw:(NSString *)newtraderpsw VerfiCode:(NSString *)verfiCode SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        
        NSArray *signArr = @[token,memberphone,[YUUEncryMgr sha1:newtraderpsw],verfiCode];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"memberphone": memberphone,
                                   @"newtraderpsw": [YUUEncryMgr sha1:newtraderpsw],
                                   @"code" : verfiCode,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/forgettraderpsw/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
