//
//  YUUMachineListRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMachineListRequest.h"
#import "YUUMachineArrModel.h"

@implementation YUUMachineListRequest
-(id)initWithMachineList:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
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
    return @"/allmymills/";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
//        if(data!=nil){
//            YUUMachineArrModel *modelList = [[YUUMachineArrModel alloc]init];
//            modelList = data[@"memberpower"];
//            modelList = data[@"memberdaycoin"];
//            NSArray *modelArr = data[@"msgList"];
//            for (NSDictionary *oneDic in modelArr) {
//                YUUMachineDetailModel *m = [[YUUMachineDetailModel alloc]initWtihDic:oneDic];
//                [modelList.machineArr addObject:m];
//            }
//            [self getResponse].data=modelList;
//        }
        [self getResponse].data = [YUUMachineArrModel mj_objectWithKeyValues:data];
    }
}
@end
