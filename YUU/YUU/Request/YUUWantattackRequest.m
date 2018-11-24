//
//  YUUWantattackRequest.m
//  YUU
//
//  Created by apple on 2018/11/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUWantattackRequest.h"

@implementation YUUWantattackRequest
-(id)initWithCanDefense:(NSString *)token Warzone:(NSString *)warzone SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self = [super initWithSuccessCallback:success failureCallback:failed];
    if (self) {
        NSArray *signArr = @[warzone];
        NSString *sha1key = getSignFromParameter(signArr);
        NSDictionary *parameters=@{
                                   @"warzone": warzone,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/wantattack/";
}

-(NSString *)getMethod{
    return @"POST";
}


@end
