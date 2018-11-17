//
//  GetAttackListRequest.h
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"

@interface GetAttackListRequest : BaseHTTP

- (instancetype)initWarzone:(NSString *)warzone
                    success:(onSuccessCallback)success
                    failure:(onFailureCallback)failure;

@end
