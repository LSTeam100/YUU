//
//  YUUSendMessageRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSendMessageRequest.h"

@implementation YUUSendMessageRequest
-(id)initWithSendMessage:(NSNumber *)memberphone SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSDictionary *parameters=@{
                                   @"memberphone": memberphone,
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/sendmessage";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
