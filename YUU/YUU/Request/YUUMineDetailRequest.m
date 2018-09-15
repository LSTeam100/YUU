//
//  YUUMineDetailRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineDetailRequest.h"
#import "YUUMineDetailModel.h"
@implementation YUUMineDetailRequest
-(id)initWithMineDetail:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/memberdata/";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUMineDetailModel *result = [[YUUMineDetailModel alloc]init];
            result.upmemberid = data[@"upmemberid"];
            result.memberphone = data[@"memberphone"];
            result.memberwx = data[@"memberwx"];
            result.memberalipay = data[@"memberalipay"];
            result.memberwallet = data[@"memberwallet"];
            result.membername = data[@"membername"];
            result.membercardid = data[@"membercardid"];
            result.bankname = data[@"bankname"];
            result.bankcard = data[@"bankcard"];
            [self getResponse].data=result;
        }
    }
}
@end
