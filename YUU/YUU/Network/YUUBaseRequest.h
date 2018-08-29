//
//  YUUBaseRequest.h
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUUResponse.h"
@class YUUBaseRequest;
static NSString * const BaseAddress = @"http://www.baidu.com";

typedef void(^onSuccessCallback)(YUUBaseRequest* request);
typedef void(^onFailureCallback)(YUUBaseRequest* request);

@interface YUUBaseRequest : NSObject

-(NSString*)getMethod;

-(NSString*)getURL;

-(void)processResponse:(NSDictionary *)responseDictionary;

-(void)setParameters:(NSDictionary *)parameters;

-(YUUResponse *)getResponse;

-(void)start;

//-(void)updateSessionId:(NSString *)sessionId;

-(onFailureCallback)failCallback;
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed;

@end
