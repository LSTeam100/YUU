//
//  YUUMineMarketRequest.h
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUPriceModel.h"

@interface YUUMineMarketRequest : BaseHTTP

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure;

@end
