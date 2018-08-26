//
//  YUUUserModel.h
//  YUU
//
//  Created by boli on 2018/8/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

typedef NS_ENUM(NSInteger, YUUUserLevel) {
    YUUUserLevelNew = 0,
};

@interface YUUUserModel : YUUBaseModel

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, assign) YUUUserLevel uerLevel;

@property (nonatomic, strong) NSString *userIcon;

@property (nonatomic, assign) NSInteger power;

@property (nonatomic, assign) NSInteger machineCount;

@property (nonatomic, assign) NSInteger directPush;

@property (nonatomic, assign) NSInteger groupNumberCount;

@end
