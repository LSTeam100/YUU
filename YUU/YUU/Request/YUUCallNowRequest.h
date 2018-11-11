//
//  YUUCallNowRequest.h
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUCallNowRequest : YUUBaseRequest
-(id)initWithCallNow:(NSString *)token Callarea:(NSString *)callarea Calltext:(NSString *)calltext SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
