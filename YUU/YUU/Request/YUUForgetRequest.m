//
//  YUUForgetRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUForgetRequest.h"
#import "YUUCommonModel.h"
@implementation YUUForgetRequest

-(id)initWithMobilePhone:(NSNumber *)phoneNum
                Password:(NSString *)password IDCode:(NSNumber *)idCode SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[ @"memberphone",@"loginpassword",@"code",@"deviceid"];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"memberphone": phoneNum,
                                   @"loginpassword":password,
                                   @"code":idCode,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}

-(NSString *)getURL{
    return @"/forgetlogin";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUCommonModel *result=[[YUUCommonModel alloc]init];
            result.headphoto = data[@"headphoto"];
            result.membergrade = data[@"membergrade"];
            result.memberid = data[@"memberid"];
            result.certification = data[@"certification"];
            result.propertynum = data[@"propertynum"];
            result.canuseyuu = data[@"canuseyuu"];
            result.frozenyuu = data[@"frozenyuu"];
            result.lockedyuu = data[@"lockedyuu"];
            result.newnews = data[@"newnews"];
            result.token = data[@"token"];
            [self getResponse].data=result;
        }
    }
}
@end
