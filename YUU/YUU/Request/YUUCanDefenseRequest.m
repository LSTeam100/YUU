//
//  YUUCanDefenseRequest.m
//  YUU
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUCanDefenseRequest.h"

@implementation YUUCanDefenseRequest
-(id)initWithCanDefense:(NSString *)token FirstCard:(NSString *)firstCard secondCard:(NSString *)SecondCard ThirdCard:(NSString *)thirdCard YuuNum:(NSString *)yuuNum SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self = [super initWithSuccessCallback:success failureCallback:failed];
    if (self) {
        NSArray *signArr = @[firstCard,SecondCard,thirdCard,yuuNum,token];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"firstcard": firstCard,
                                   @"secondcard": SecondCard,
                                   @"thirdcard":thirdCard,
                                   @"yuunum":yuuNum,
                                   @"token": token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];

    }
    return self;
}
-(NSString *)getURL{
    return @"/candefense/";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
