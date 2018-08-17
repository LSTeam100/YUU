//
//  YUUMachineModel.h
//  YUU
//
//  Created by boli on 2018/8/17.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUMachineModel : NSObject

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger power;

@property (nonatomic, assign) NSInteger OperationCycle;

@property (nonatomic, assign) float income;

@end
