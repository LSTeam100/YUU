//
//  YUUMilltraderRequest.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"
#import "YUUMilltraderModel.h"
#import "Header.h"

@interface YUUMilltraderRequest : YUUBaseRequest

-(id)initWithMilltrader:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;

@end
