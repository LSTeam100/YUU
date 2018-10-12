//
//  YUUPendingSellenterRequest.h
//  YUU
//
//  Created by boli on 2018/10/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"

@interface YUUPendingSellenterRequest : BaseHTTP

- (instancetype)initWithTradingcard:(NSString *)tradingcard
                           password:(NSString *)password
                            success:(onSuccessCallback)success
                            failure:(onFailureCallback)failure;

@end
