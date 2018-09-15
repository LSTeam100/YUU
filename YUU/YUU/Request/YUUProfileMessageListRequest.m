//
//  YUUProfileMessageListRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUProfileMessageListRequest.h"
#import "YUUMsgModel.h"
@implementation YUUProfileMessageListRequest
-(id)initWithMessagelist:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        NSArray *signArr = @[token];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token":token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/newslist/";
}

-(NSString *)getMethod{
    return @"POST";
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            YUUMsgModelList *modelList = [[YUUMsgModelList alloc]init];
            NSArray *modelArr = data[@"msgList"];
            for (NSDictionary *oneDic in modelArr) {
                YUUMsgModel *m = [[YUUMsgModel alloc]initWtihDic:oneDic];
                [modelList.msgList addObject:m];
            }
            [self getResponse].data=modelList;
        }
    }
}

@end
