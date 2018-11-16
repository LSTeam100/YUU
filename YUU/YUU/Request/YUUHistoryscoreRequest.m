//
//  YUUHistoryscoreRequest.m
//  YUU
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUHistoryscoreRequest.h"

@implementation YUUHistoryscoreRequest
-(id)initWithHisScore:(NSString *)token LastId:(NSString *)lastId SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[token,lastId];
        
        
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"lastid": lastId,
                                   @"token": token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/historyscore/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
