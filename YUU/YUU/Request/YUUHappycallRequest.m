//
//  YUUHappycallRequest.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUHappycallRequest.h"

@implementation YUUHappycallRequest
-(id)initWithHappycall:(NSString *)callarea LastId:(NSString *)lastId Refreshid:(NSString *)refreshid SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[callarea,lastId,refreshid];
        
        
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"callarea": callarea,
                                   @"latestid": lastId,
                                   @"refreshid": refreshid,
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
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        [self getResponse].data = data;
    }
}

@end
