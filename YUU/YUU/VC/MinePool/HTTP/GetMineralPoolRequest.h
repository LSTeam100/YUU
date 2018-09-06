//
//  GetMinePoolRequest.h
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "MineralPoolModel.h"

@interface GetMineralPoolRequest : BaseHTTP

- (instancetype)initWithSuccess:(onSuccessCallback)success
                        failure:(onFailureCallback)failure;

@end
