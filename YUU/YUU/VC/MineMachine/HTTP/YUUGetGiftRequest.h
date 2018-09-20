//
//  YUUGetGiftRequest.h
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"

@interface YUUGetGiftRequest : BaseHTTP

- (instancetype)initWithMillid:(NSString *)millid
                        uccess:(onSuccessCallback)success
                       failure:(onFailureCallback)failure;

@end
