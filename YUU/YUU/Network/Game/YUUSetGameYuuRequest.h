//
//  YUUSetGameYuuRequest.h
//  YUU
//
//  Created by boli on 2018/12/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUUSetGameYuuRequest : BaseHTTP

- (instancetype)initWithYuunum:(float)yuunum
                       success:(onSuccessCallback)success
                       failure:(onFailureCallback)failure;

@end

NS_ASSUME_NONNULL_END
