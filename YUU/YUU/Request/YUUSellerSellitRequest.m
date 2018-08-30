//
//  YUUSellerSellitRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSellerSellitRequest.h"
#import "YUUSellerSellitModel.h"
@implementation YUUSellerSellitRequest
-(id)initWithSellerSellit:(NSString *)token Tradingcard:(NSString *)tradingcard SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
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
    return @"/sellit";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUSellerSellitModel *model = [[YUUSellerSellitModel alloc]init];
            model.membername = data[@"membername"];
            model.bankname = data[@"bankname"];
            model.bankcard = data[@"bankcard"];
            model.memberwx = data[@"memberwx"];
            model.memberalipay = data[@"memberalipay"];
            model.memberphone = data[@"memberphone"];
            model.memberwallet = data[@"memberwallet"];
            [self getResponse].data=model;
        }
    }
}

@end
