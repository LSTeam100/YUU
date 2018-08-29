//
//  YUURegisterRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUURegisterRequest.h"
#import "YUURegisterResult.h"
@implementation YUURegisterRequest

-(id)initWithMobilePhone:(NSNumber *)phoneNum IDCode:(NSNumber *)idCode
                Password:(NSString *)password DeviceId:(NSString *)deviceId SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if(self){
        
        NSArray *signArr = @[ @"upmemberip",@"code",@"memberphone",@"loginpassword",@"deviceid"];
        NSString *sha1key = getSignFromParameter(signArr);
        DLOG(@"sha1key=%@",sha1key);
        
        NSDictionary *parameters=@{
                                   @"upmemberip": phoneNum,
                                   @"code": idCode,
                                   @"memberphone": phoneNum,
                                   @"loginpassword":password,
                                   @"deviceid" : [UIDevice IDFAString],
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/registerapp";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUURegisterResult *result=[[YUURegisterResult alloc]init];
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
