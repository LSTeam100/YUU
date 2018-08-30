//
//  YUUCallCenterRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUCallCenterRequest : YUUBaseRequest
-(id)initWithCallCenter:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
