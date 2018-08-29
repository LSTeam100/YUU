//
//  YUULoginRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUULoginRequest.h"

@implementation YUULoginRequest
-(id)initWithMobilePhone:(NSNumber *)phoneNum
                Password:(NSString *)password  SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[ @"memberip",@"loginpassword"];
        NSString *sha1key = getSignFromParameter(signArr);

        NSDictionary *parameters=@{
                                   @"memberip": phoneNum,
                                   @"loginpassword":password,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}

-(NSString *)getURL{
    return @"/loginapp";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
