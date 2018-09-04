//
//  YUULoginRequest.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUULoginRequest.h"
#import "YUUCommonModel.h"
@implementation YUULoginRequest
-(id)initWithMobilePhone:(NSNumber *)phoneNum
                Password:(NSString *)password  SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[ @"memberip",@"loginpassword"];
        NSString *sha1key = getSignFromParameter(signArr);

        NSDictionary *parameters=@{
                                   @"memberip": phoneNum,
                                   @"loginpassword":password,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}

-(NSString *)getURL{
    return @"/loginapp";
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
