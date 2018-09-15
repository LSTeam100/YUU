//
//  YUUModifyLoginRequest.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUModifyLoginRequest.h"

@implementation YUUModifyLoginRequest
-(id)initWithModifyLogin:(NSString *)token Oldpsw:(NSString *)oldpsw Newpsw:(NSString *)newpsw SuccessCallback:(onSuccessCallback)success failureCallback:(onFailureCallback)failed{
    self=[super initWithSuccessCallback:success
                        failureCallback:failed];
    if (self) {
        
        NSArray *signArr = @[token,oldpsw,newpsw];
        
        
        NSString *sha1key = getSignFromParameter(signArr);
        
        NSDictionary *parameters=@{
                                   @"token": token,
                                   @"oldpsw": oldpsw,
                                   @"newpsw": newpsw,
                                   @"sign" : sha1key
                                   };
        [self setParameters:parameters];
    }
    return self;
}
-(NSString *)getURL{
    return @"/modifyloginpsw/";
}

-(NSString *)getMethod{
    return @"POST";
}
@end
