//
//  YUUMachineModel.h
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUUBaseModel.h"



@interface YUUMachineModel : YUUBaseModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger compower; // 算力
@property (nonatomic, assign) NSInteger totaldays; // 总运行天数
@property (nonatomic, assign) double totalcoins; // 总收益量
@property (nonatomic, assign) NSInteger millprice;

@property (nonatomic, assign) YUUMilltype type;
@property (nonatomic, strong) NSString *typeName;


@property (nonatomic, assign) YUUMachineStatus status;
@property (nonatomic, strong) NSString *machineNumber;

@property (nonatomic, assign) NSInteger operationDay;
@property (nonatomic, assign) float output;
@property (nonatomic, assign) YUUMachineReceiveStatus receive;

@end
