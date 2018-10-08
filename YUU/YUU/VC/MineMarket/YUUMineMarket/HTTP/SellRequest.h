//
//  SellRequest.h
//  YUU
//
//  Created by boli on 2018/10/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseHTTP.h"
#import "YUUPointSellModel.h"

@interface SellRequest : BaseHTTP
- (instancetype)initWithMemberid:(NSString *)memberid
                         Sellnum:(NSString *)sellnum
                       Sellprice:(NSString *)sellprice
                         Success:(onSuccessCallback)success
                         failure:(onFailureCallback)failure;
@end
