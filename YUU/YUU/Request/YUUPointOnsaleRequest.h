//
//  YUUPointOnsaleRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUPointOnsaleRequest : YUUBaseRequest
-(id)initWithSellerTransaction:(NSString *)token Uporderstype:(NSString *)uporderstype Buynum:(NSString *)buynum Buyprice:(NSString *)buyprice SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
