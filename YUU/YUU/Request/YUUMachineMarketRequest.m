//
//  YUUMachineMarketRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMachineMarketRequest.h"

@implementation YUUMachineMarketRequest
-(id)initWithMachineMarket:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
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
    return @"/milltrader";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
//    if([[self getResponse] isSucceed]){
//        NSDictionary* data=responseDictionary[@"data"];
//        if(data!=nil){
//            YUUMachinePoolArrModel *modelList = [[YUUMachinePoolArrModel alloc]init];
//            modelList = data[@"millspoolpower"];
//            modelList = data[@"totalminers"];
//            modelList = data[@"threeminer"];
//            modelList = data[@"totaldirect"];
//            modelList = data[@"twominer"];
//            modelList = data[@"oneminer"];
//            modelList = data[@"actminer"];
//            modelList = data[@"fourminer"];
//            
//            NSArray *directidTmp = data[@"directid"];
//            NSArray *nodirectidTmp = data [@"nodirectid"];
//            
//            for (NSDictionary *oneDic in directidTmp) {
//                YUUMachinePoolModel *m = [[YUUMachinePoolModel alloc]initWtihDic:oneDic];
//                [modelList.directidArr addObject:m];
//            }
//            
//            for (NSDictionary *oneDic in nodirectidTmp) {
//                YUUMachinePoolModel *m = [[YUUMachinePoolModel alloc]initWtihDic:oneDic];
//                [modelList.nodirectidArr addObject:m];
//            }
//            
//            [self getResponse].data=modelList;
//        }
//    }
}
@end
