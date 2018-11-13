//
//  YUUCancelTransactionRequest.h
//  YUU
//
//  Created by boli on 2018/11/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"

@interface YUUCancelTransactionRequest : BaseHTTP

- (instancetype)initWithTradingcard:(NSString *)tradingcard
                            success:(onSuccessCallback)success
                            failure:(onFailureCallback)failure;

@end
