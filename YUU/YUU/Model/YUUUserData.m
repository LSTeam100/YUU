//
//  YUUUserData.m
//  YUU
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUUserData.h"

@implementation YUUUserData

+ (instancetype)shareInstance{
    static YUUUserData *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[YUUUserData alloc]init];
    });
    return user;
}

-(void)saveUserData:(NSNumber *)userName{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:userName forKey:kUserAccountKey];
//    [userdefault setObject:password forKey:kUserPasswordKey];
    [userdefault synchronize];
}
-(void)getUserData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.userName = [userDefault objectForKey:kUserAccountKey];
    if (self.userName != nil) {
        self.haveSigned = YES;
    }
}


@end
