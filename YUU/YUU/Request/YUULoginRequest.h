//
//  YUULoginRequest.h
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUULoginRequest : YUUBaseRequest
-(id)initWithMobilePhone:(NSNumber *)phoneNum
                Password:(NSString *)password  SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
