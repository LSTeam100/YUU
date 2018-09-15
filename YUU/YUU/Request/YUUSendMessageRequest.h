//
//  YUUSendMessageRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUSendMessageRequest : YUUBaseRequest
-(id)initWithSendMessage:(NSString *)memberphone SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
