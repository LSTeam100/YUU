//
//  YUUStartAttackRequest.h
//  YUU
//
//  Created by apple on 2018/11/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUStartAttackRequest : YUUBaseRequest
-(id)initWithStartattack:(NSString *)token FirstCard:(NSString *)firstCard secondCard:(NSString *)SecondCard ThirdCard:(NSString *)thirdCard Battlenum:(NSString *)battlenum SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
