//
//  YUUMineMarketMailRequest.h
//  YUU
//
//  Created by boli on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUPendingMailboxModel.h"

@interface YUUMineMarketMailRequest : BaseHTTP

- (instancetype)initSuccess:(onSuccessCallback)success
                    failure:(onFailureCallback)failure;

@end
