//
//  YUUBuyMachineRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBuyMachineRequest.h"

@implementation YUUBuyMachineRequest
-(id)initWithBuyMachine:(NSString *)token Milltype:(NSNumber *)milltype SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token,milltype];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"milltype" : milltype,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/themillprice/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
