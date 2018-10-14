//
//  YUUMachineArrModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"


@interface YUUMachineDetailModel :NSObject
@property(nonatomic,strong)NSString *millsize;
@property (nonatomic, strong) NSString *millid;
@property(nonatomic, strong) NSString *milltype;
//@property(nonatomic,strong) NSString *milltypeName;
@property(nonatomic,strong)NSNumber *runtimeday;
@property(nonatomic,strong)NSNumber *totaldays;
@property(nonatomic,strong)NSString *compower;
@property(nonatomic,strong)NSNumber *outputcoins;
@property(nonatomic,assign) YUUMachineReceiveStatus getmill;
@property(nonatomic,assign) YUUMachineStatus milldie;
-(instancetype)initWtihDic:(NSDictionary *)dic;

@end


@interface YUUMachineArrModel : NSObject

@property(nonatomic, assign) NSInteger memberpower;
@property(nonatomic, assign) double memberdaycoin;
@property(nonatomic, strong) NSArray *msgList;

@end
