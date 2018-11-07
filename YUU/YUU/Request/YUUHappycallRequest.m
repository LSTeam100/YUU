//
//  YUUHappycallRequest.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUHappycallRequest.h"

@implementation YUUHappycallRequest
-(id)initWithHappycall:(NSString *)callarea LastId:(NSString *)lastId SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[callarea,lastId];
        
        
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"callarea": callarea,
                                   @"latestid": lastId,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/happycall/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
