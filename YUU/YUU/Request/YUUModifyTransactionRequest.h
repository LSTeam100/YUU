//
//  YUUModifyTransactionRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUModifyTransactionRequest : YUUBaseRequest
-(id)initWithModifyTransaction:(NSString *)token Oldtraderpsw:(NSString *)oldtraderpsw Newtraderpsw:(NSString *)newtraderpsw SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
