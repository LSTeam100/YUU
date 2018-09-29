//
//  YUUPointSellRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPointSellRequest.h"
#import "YUUPointSellModel.h"
@implementation YUUPointSellRequest
-(id)initWithMemberid:(NSString *)memberid
               Sellnum:(NSString *)sellnum
             Sellprice:(NSString *)sellprice
       SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSDictionary *parameters=@{
                                   @"sellnum" : sellnum,
                                   @"memberid" : memberid,
                                   @"sellprice" : sellprice
                                   };
        [self setParameterDic:parameters];
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
