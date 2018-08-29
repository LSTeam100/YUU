//
//  YUUForgetRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUForgetRequest.h"

@implementation YUUForgetRequest

-(id)initWithMobilePhone:(NSNumber *)phoneNum
                Password:(NSString *)password IDCode:(NSNumber *)idCode SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[ @"memberphone",@"loginpassword",@"code",@"deviceid"];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"memberphone": phoneNum,
                                   @"loginpassword":password,
                                   @"code":idCode,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}

-(NSString *)getURL{
    return @"/forgetlogin";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
