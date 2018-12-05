//
//  GetOrderweekrankingRequest.h
//  YUU
//
//  Created by boli on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUBaseModel.h"

@interface GetOrderweekrankingRequest : BaseHTTP

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure;

@end
