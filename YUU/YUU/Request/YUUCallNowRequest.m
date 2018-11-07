//
//  YUUCallNowRequest.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUCallNowRequest.h"

@implementation YUUCallNowRequest
-(id)initWithCallNow:(NSString *)token Callarea:(NSString *)callarea Calltext:(NSString *)calltext SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[callarea,calltext,token];
        
        
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"callarea": callarea,
                                   @"calltext": calltext,
                                   @"token": token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/callnow/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
