//
//  YUUGetPendingOrderBuyerRequest.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUPendingBuyerModel.h"

@interface YUUGetPendingOrderBuyerRequest : BaseHTTP

- (instancetype)initWithUserLevel:(UserLevel)level
                          success:(onSuccessCallback)success
                          failure:(onFailureCallback)failure;

@end
