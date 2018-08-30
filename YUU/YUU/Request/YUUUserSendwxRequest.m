//
//  YUUUserSendwxRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUUserSendwxRequest.h"

@implementation YUUUserSendwxRequest
-(id)initWithSendwx:(NSString *)token Memberwx:(NSString *)memberwx SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[@"token",@"memberwx"];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"memberwx":memberwx,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/memberwx";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
