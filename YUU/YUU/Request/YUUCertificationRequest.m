//
//  YUUCertificationRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCertificationRequest.h"

@implementation YUUCertificationRequest
//-(id)initWithCertification:(NSNumber *)name
//              Membercardid:(NSString *)membercardid Bankcard:(NSNumber *)bankcard bankphone:() SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
//    self=[super initWithSuccessCallback:success
//                        failureCallback:failed];
//    if (self) {
//        NSArray *signArr = @[ @"membername",@"membercardid",@"bankcard",@"bankphone",@"code",@"token"];
//        NSString *sha1key = getSignFromParameter(signArr);
//
//        NSDictionary *parameters=@{
//                                   @"membername": phoneNum,
//                                   @"loginpassword":password,
//                                   @"code":idCode,
//                                   @"sign" : sha1key
//                                   };
//        [self setParameters:parameters];
//    }
//    return self;
//}

-(NSString *)getURL{
    return @"/certification";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
