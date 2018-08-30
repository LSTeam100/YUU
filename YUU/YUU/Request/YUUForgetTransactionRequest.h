//
//  YUUForgetTransactionRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUForgetTransactionRequest : YUUBaseRequest
-(id)initWithForgetTransaction:(NSString *)token Memberphone:(NSString *)memberphone Newtraderpsw:(NSString *)newtraderpsw VerfiCode:(NSString *)verfiCode SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
