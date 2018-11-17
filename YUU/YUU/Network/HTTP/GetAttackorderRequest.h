//
//  GetAttackorderRequest.h
//  YUU
//
//  Created by boli on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"

@interface GetAttackorderRequest : BaseHTTP

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure;

@end
