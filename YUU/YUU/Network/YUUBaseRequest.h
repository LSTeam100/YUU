//
//  YUUBaseRequest.h
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUUResponse.h"
#import "YUUUserData.h"

@class YUUBaseRequest;
static NSString * const BaseAddress = @"https://yuuleyou.com";
static NSString * const TestAddress = @"http://47.110.32.18:8080";

typedef void(^onSuccessCallback)(YUUBaseRequest* request);
typedef void(^onFailureCallback)(YUUBaseRequest* request);

@interface YUUBaseRequest : NSObject

-(NSString*)getMethod;

-(NSString*)getURL;

-(void)processResponse:(NSDictionary *)responseDictionary;

-(void)setParameters:(NSDictionary *)parameters;
- (void)setParameterDic:(NSDictionary *)dict;

-(YUUResponse *)getResponse;

-(void)start;

//-(void)updateSessionId:(NSString *)sessionId;

-(onFailureCallback)failCallback;
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed;

@end
