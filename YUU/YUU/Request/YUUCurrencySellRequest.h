//
//  YUUCurrencySellRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUCurrencySellRequest : YUUBaseRequest
-(id)initWithCurrencySell:(NSString *)token Coinsite:(NSString *)coinsite Coinnum:(NSString *)coinnum password:(NSString *)password SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
