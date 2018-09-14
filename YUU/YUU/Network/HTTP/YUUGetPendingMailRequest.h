//
//  YUUGetPendingMailRequest.h
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUPendingMailboxModel.h"

@interface YUUGetPendingMailRequest : BaseHTTP

- (instancetype)initWithUserLevel:(UserLevel)level
                          success:(onSuccessCallback)success
                          failure:(onFailureCallback)failure;

@end
