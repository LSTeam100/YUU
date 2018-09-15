//
//  BaseHTTP.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"

@implementation BaseHTTP

- (NSString *)getMethod {
    return @"POST";
}

- (void)setParameters:(NSDictionary *)parameters {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    NSString *sha1key = getSignFromParameter(signArr);
//    [dict setObject:sha1key forKey:@"sign"];
    
    
    [super setParameters:dict];
}

- (void)processResponse:(NSDictionary *)responseDictionary {
    [super processResponse:responseDictionary];
    if([[self getResponse] isSucceed]){
        NSDictionary* data=responseDictionary[@"data"];
        if(data!=nil){
            [self getResponse].data = [self processResponseToModel:data];
        }
    }
}

- (id)processResponseToModel:(NSDictionary *)dict {
    return nil;
}



@end
