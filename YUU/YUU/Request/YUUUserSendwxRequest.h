//
//  YUUUserSendwxRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUUserSendwxRequest : YUUBaseRequest
-(id)initWithSendwx:(NSString *)token Memberwx:(NSString *)memberwx SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;


@end
