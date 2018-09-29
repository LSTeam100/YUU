//
//  YUUPointSellRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUPointSellRequest : YUUBaseRequest
-(id)initWithMemberid:(NSString *)memberid  Sellnum:(NSString *)sellnum Sellprice:(NSString *)sellprice SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
