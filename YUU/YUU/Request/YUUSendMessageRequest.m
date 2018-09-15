//
//  YUUSendMessageRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSendMessageRequest.h"

@implementation YUUSendMessageRequest
-(id)initWithSendMessage:(NSString *)memberphone SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[memberphone,[UIDevice IDFAString]];
        NSString *sha1key = getSignFromParameter(signArr);
        DLOG(@"sha1key=%@",sha1key);
        
        NSDictionary *parameters=@{
                                   @"memberphone": memberphone,
                                   @"deviceid" : [UIDevice IDFAString],
                                   @"sign" : sha1key,
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/sendmessage/";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
