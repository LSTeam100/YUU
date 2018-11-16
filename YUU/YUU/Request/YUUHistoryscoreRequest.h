//
//  YUUHistoryscoreRequest.h
//  YUU
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUHistoryscoreRequest : YUUBaseRequest
-(id)initWithHisScore:(NSString *)token LastId:(NSString *)lastId SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
