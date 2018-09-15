//
//  BaseHTTP.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface BaseHTTP : YUUBaseRequest

- (id)processResponseToModel:(NSDictionary *)dict;

@end
