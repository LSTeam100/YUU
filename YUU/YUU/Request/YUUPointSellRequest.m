//
//  YUUPointSellRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPointSellRequest.h"
#import "YUUPointSellModel.h"
#import "YUUEncryMgr.h"

@implementation YUUPointSellRequest

-(id)initWithMemberid:(NSString *)memberid
               Sellnum:(NSString *)sellnum
             Sellprice:(NSString *)sellprice
             password:(NSString *)password
       SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        double price = [sellprice doubleValue];
        NSString * priceKey = [NSString stringWithFormat: @"%.1lf", price];
        NSArray *signArr = @[sellnum,memberid,priceKey,[YUUUserData shareInstance].token, [YUUEncryMgr sha1:password]];
        NSString *sha1key = getSignFromParameter(signArr);

        NSDictionary *parameters=@{
                                   @"sellnum" : sellnum,
                                   @"memberid" : memberid,
                                   @"sellprice" : sellprice,
                                   @"token" : [YUUUserData shareInstance].token,
                                   @"sign" : sha1key,
                                   @"tradepsw" : [YUUEncryMgr sha1:password]
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/pointsell/";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUPointSellModel *model = [[YUUPointSellModel alloc]init];
            model = data[@"tradingcard"];
            model = data[@"tradingtime"];
            model = data[@"membername"];
            model = data[@"bankname"];
            model = data[@"bankcard"];
            model = data[@"memberwx"];
            model = data[@"memberalipay"];
            model = data[@"memberphone"];
            model = data[@"memberwallet"];
            [self getResponse].data=model;
        }
    }
}

@end
