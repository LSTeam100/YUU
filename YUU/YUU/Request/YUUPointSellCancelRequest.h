//
//  YUUPointSellCancelRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUPointSellCancelRequest : YUUBaseRequest
-(id)initWithPointSellCancel:(NSString *)token Tradingcard:(NSString *)tradingcard SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
