//
//  GetAttackListRequest.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GetAttackListRequest.h"
#import "DefensiveListModel.h"

@implementation GetAttackListRequest

- (instancetype)initWarzone:(NSString *)warzone
                    success:(onSuccessCallback)success
                    failure:(onFailureCallback)failure
{
    self = [super initWithSuccessCallback:success failureCallback:failure];
    
    [self setParameterDic:@{@"warzone":warzone} withToken:NO];
    
    return self;
}


- (NSString *)getURL {
    return @"/wantattack/";
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
    NSDictionary *dict = [responseDictionary objectForKey:@"data"];
    NSArray *list = [dict objectForKey:@"msgList"];
    self.getResponse.data = [DefensiveListModel mj_objectArrayWithKeyValuesArray:list];
}

@end
