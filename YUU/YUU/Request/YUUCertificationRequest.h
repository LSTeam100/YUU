//
//  YUUCertificationRequest.h
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"

@interface YUUCertificationRequest : YUUBaseRequest
-(id)initWithCertification:(NSString *)name
              Membercardid:(NSString *)membercardid Bankcard:(NSString *)bankcard Bankphone:(NSString *)bankphone Code:(NSString *)code Token:(NSString *)token SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed;
@end
