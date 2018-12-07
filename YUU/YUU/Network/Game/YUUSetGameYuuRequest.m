//
//  YUUSetGameYuuRequest.m
//  YUU
//
//  Created by boli on 2018/12/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSetGameYuuRequest.h"

@implementation YUUSetGameYuuRequest

- (instancetype)initWithYuunum:(float)yuunum
                      success:(onSuccessCallback)success
                      failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"yuunum":[NSNumber numberWithFloat:yuunum]}];
    
    return self;
}


- (NSString *)getURL {
    return @"/thisyuunum/";
}

//- (void)processResponse:(NSDictionary *)responseDictionary {
//    [super processResponse:responseDictionary];
//}

@end
