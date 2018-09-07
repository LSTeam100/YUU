//
//  YUULauchAppRequest.h
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUULauchAppRequest : YUUBaseRequest
-(id)initWithAppRequest:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
