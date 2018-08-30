//
//  YUUSellerTransactionRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSellerTransactionRequest.h"

@implementation YUUSellerTransactionRequest
-(id)initWithSellerTransaction:(NSString *)token Tradingcard:(NSString *)tradingcard SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[@"token",@"tradingcard"];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"sign" : sha1key,
                                   @"tradingcard" : tradingcard
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/pointsellenter";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
