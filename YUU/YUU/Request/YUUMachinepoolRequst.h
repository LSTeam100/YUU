//
//  YUUMachinepoolRequst.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUMachinepoolRequst : YUUBaseRequest
-(id)initWithMachinepool:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
