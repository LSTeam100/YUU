//
//  YUUModifyLoginRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUModifyLoginRequest : YUUBaseRequest
-(id)initWithModifyLogin:(NSString *)token Oldpsw:(NSString *)oldpsw Newpsw:(NSString *)newpsw SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
