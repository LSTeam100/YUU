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


+ (instancetype)shareInstance;
-(void)getUserData;
-(void)saveUserData:(YUUCommonModel *)userModel;
@end
