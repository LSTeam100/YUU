//
//  YUUMachineArrModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YUUMachineDetailModel :NSObject
@property(nonatomic,strong)NSString *millsize;
@property(nonatomic,strong)NSNumber *milltype;
@property(nonatomic,strong)NSNumber *runtimeday;
@property(nonatomic,strong)NSNumber *totaldays;
@property(nonatomic,strong)NSString *compower;
@property(nonatomic,strong)NSNumber *outputcoins;
@property(nonatomic,strong)NSNumber *getmill;
@property(nonatomic,strong)NSNumber *milldie;
-(instancetype)initWtihDic:(NSDictionary *)dic;

@end


@interface YUUMachineArrModel : NSObject
@property(nonatomic,strong)NSNumber *memberpower;
@property(nonatomic,strong)NSNumber *memberdaycoin;
@property(nonatomic,strong)NSMutableArray <YUUMachineDetailModel *>*machineArr;

@end
