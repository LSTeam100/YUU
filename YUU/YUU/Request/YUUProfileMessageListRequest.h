//
//  YUUProfileMessageListRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUProfileMessageListRequest : YUUBaseRequest
-(id)initWithMessagelist:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
