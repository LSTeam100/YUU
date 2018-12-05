//
//  WarbackRequest.h
//  YUU
//
//  Created by boli on 2018/12/4.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseHTTP.h"

NS_ASSUME_NONNULL_BEGIN

@interface WarbackRequest : BaseHTTP

- (instancetype)initBattlenum:(NSString *)battlenum
                      success:(onSuccessCallback)success
                      failure:(onFailureCallback)failure;

@end

NS_ASSUME_NONNULL_END
