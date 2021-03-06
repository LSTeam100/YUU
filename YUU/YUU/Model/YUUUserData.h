//
//  YUUUserData.h
//  YUU
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUUCommonModel.h"
@interface YUUUserData : NSObject 
@property(nonatomic,assign)BOOL haveSigned;
@property(nonatomic,strong)YUUCommonModel *userModel;
//@property(nonatomic,strong)NSString *userName;
@property (nonatomic, strong) NSString *token;


+ (instancetype)shareInstance;
-(void)getUserData;
-(void)saveUserData:(YUUCommonModel *)userModel;
-(void)removeUserData;
@end
