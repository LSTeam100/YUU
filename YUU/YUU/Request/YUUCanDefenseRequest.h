//
//  YUUCanDefenseRequest.h
//  YUU
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUCanDefenseRequest : YUUBaseRequest
-(id)initWithCanDefense:(NSString *)token FirstCard:(NSString *)firstCard secondCard:(NSString *)SecondCard ThirdCard:(NSString *)thirdCard YuuNum:(NSString *)yuuNum SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
