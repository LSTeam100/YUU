//
//  YUUStartAttackRequest.m
//  YUU
//
//  Created by apple on 2018/11/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUStartAttackRequest.h"

@implementation YUUStartAttackRequest
-(id)initWithStartattack:(NSString *)token FirstCard:(NSString *)firstCard secondCard:(NSString *)SecondCard ThirdCard:(NSString *)thirdCard Battlenum:(NSString *)battlenum SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self = [super initWithSuccessCallback:success failureCallback:failed];
    if (self) {
        NSArray *signArr = @[firstCard,SecondCard,thirdCard,battlenum,token];
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"firstcard": firstCard,
                                   @"secondcard": SecondCard,
                                   @"thirdcard":thirdCard,
                                   @"battlenum":battlenum,
                                   @"token": token,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
        
    }
    return self;
}
-(NSString *)getURL{
    return @"/startattack/";
}

-(NSString *)getMethod{
    return @"POST";
}

@end
