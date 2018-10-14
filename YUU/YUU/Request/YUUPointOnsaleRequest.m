//
//  YUUPointOnsaleRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPointOnsaleRequest.h"

@implementation YUUPointOnsaleRequest
-(id)initWithSellerTransaction:(NSString *)token Uporderstype:(NSString *)uporderstype Buynum:(NSString *)buynum Buyprice:(NSString *)buyprice SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
//        double price = [buyprice doubleValue];
//        NSString * priceKey = [NSString stringWithFormat: @"%.1lf", price];
        NSArray *signArr = @[token,uporderstype,buynum,buyprice];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"sign" : sha1key,
                                   @"uporderstype" : uporderstype,
                                   @"buynum" : buynum,
                                   @"buyprice" : buyprice
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/upordersbuy/";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
