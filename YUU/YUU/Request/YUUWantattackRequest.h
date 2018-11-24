//
//  YUUWantattackRequest.h
//  YUU
//
//  Created by apple on 2018/11/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUWantattackRequest : YUUBaseRequest
-(id)initWithCanDefense:(NSString *)token Warzone:(NSString *)warzone SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
