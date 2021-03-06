//
//  YUUModifyTransactionRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUModifyTransactionRequest.h"

@implementation YUUModifyTransactionRequest
-(id)initWithModifyTransaction:(NSString *)token Oldtraderpsw:(NSString *)oldtraderpsw Newtraderpsw:(NSString *)newtraderpsw SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[token,[YUUEncryMgr sha1:oldtraderpsw],[YUUEncryMgr sha1:newtraderpsw]];;
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"oldtraderpsw": [YUUEncryMgr sha1:oldtraderpsw],
                                   @"newtraderpsw": [YUUEncryMgr sha1:newtraderpsw],
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/modifytraderpsw/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
