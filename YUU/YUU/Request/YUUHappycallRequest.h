//
//  YUUHappycallRequest.h
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUHappycallRequest : YUUBaseRequest
-(id)initWithHappycall:(NSString *)callarea LastId:(NSString *)lastId SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
