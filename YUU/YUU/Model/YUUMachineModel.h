//
//  YUUMachineModel.h
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUUBaseModel.h"

typedef NS_ENUM(NSUInteger, YUUMachineStatus) {
    YUUMachineStatusDefault = 0,
    
};

typedef NS_ENUM(NSInteger, YUUMachineType) {
    YUUMachineTypeNew = 0,
};

typedef NS_ENUM(NSInteger, YUUMachineReceiveStatus) {
    YUUMachineReceiveNo = 0,
    YUUMachineReceived = 1,
};

@interface YUUMachineModel : YUUBaseModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger power;
@property (nonatomic, assign) NSInteger operationCycle;
@property (nonatomic, assign) float allIncome;
@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) YUUMachineStatus status;
@property (nonatomic, strong) NSString *machineNumber;
@property (nonatomic, assign) YUUMachineType type;
@property (nonatomic, assign) NSInteger operationDay;
@property (nonatomic, assign) float output;
@property (nonatomic, assign) YUUMachineReceiveStatus receive;

@end
