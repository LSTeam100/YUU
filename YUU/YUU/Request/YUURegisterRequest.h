//
//  YUURegisterRequest.h
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUURegisterRequest : YUUBaseRequest
-(id)initWithMobilePhone:(NSString *)phoneNum IDCode:(NSNumber *)idCode
                Password:(NSString *)password UpMemberip:(NSString *)upmemberip SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;


@end
