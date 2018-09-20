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

-(void)saveUserData:(YUUCommonModel *)userModel{
    _userModel = userModel;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    [userdefault setObject:userData forKey:kUserAccountKey];
    [userdefault synchronize];
}

- (YUUCommonModel *)userModel {
    if (!_userModel) {
        [self getUserData];
    }
    return _userModel;
}

- (NSString *)token {
    if (self.userModel.token) {
        return self.userModel.token;
    }
    NSAssert(1, @"");
    return @"";
}

-(void)getUserData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:kUserAccountKey];
    _userModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (_userModel != nil) {
        DLOG(@"self.userModel.memberid=%@",_userModel.memberid);
        self.haveSigned = YES;
    }
}
-(void)removeUserData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kUserAccountKey];
    self.userModel = nil;
    self.haveSigned = false;
}


@end
