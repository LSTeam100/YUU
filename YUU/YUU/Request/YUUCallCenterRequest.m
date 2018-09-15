//
//  YUUCallCenterRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCallCenterRequest.h"

@implementation YUUCallCenterRequest
-(id)initWithCallCenter:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
//        NSString *sha1key = getSignFromParameter(signArr);
//
//        NSDictionary *parameters=@{
//                                   @"token": token,
//                                   @"sign" : sha1key
//                                   };
//        [self setParameters:nil];
    }
    return self;
}
-(NSString *)getURL{
    return @"/callcenter/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
