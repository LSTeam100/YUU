//
//  YUUBillCenterRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBillCenterRequest.h"
#import "YUUBillModel.h"
@implementation YUUBillCenterRequest
-(id)initWithBillCenter:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[@"token"];
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
    return @"/billcenter";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUBillModelList *modelList = [[YUUBillModelList alloc]init];
            NSArray *modelArr = data[@"msgList"];
            for (NSDictionary *oneDic in modelArr) {
                YUUBillModel *m = [[YUUBillModel alloc]initWtihDic:oneDic];
                [modelList.billModelArr addObject:m];
            }
            [self getResponse].data=modelList;
        }
    }
}
@end
