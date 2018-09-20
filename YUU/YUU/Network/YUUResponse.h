//
//  YUUResponse.h
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUResponse : NSObject

@property (nonatomic, strong) NSDictionary *responseObject;

@property(nonatomic,strong)NSNumber *success;

@property (nonatomic,assign)int code;

@property (strong, nonatomic) NSString* msg;

@property (strong, nonatomic) id data;

-(BOOL) isSucceed;

@end
