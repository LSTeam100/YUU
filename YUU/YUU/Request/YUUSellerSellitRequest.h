//
//  YUUSellerSellitRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUSellerSellitRequest : YUUBaseRequest

-(id)initWithSellerSellit:(NSString *)token Tradingcard:(NSString *)tradingcard password:(NSString *)password SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
