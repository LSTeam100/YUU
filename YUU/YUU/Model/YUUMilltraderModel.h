//
//  YUUMilltraderModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUMilltraderModel : NSObject
@property(nonatomic,strong)NSNumber *compower;
@property(nonatomic,strong)NSNumber *totaldays;
@property(nonatomic,strong)NSNumber *totalcoins;
@property(nonatomic,strong)NSNumber *millprice;
@property(nonatomic,strong)NSNumber *milltype;

-(instancetype)initWtihDic:(NSDictionary *)dic;
@end

@interface YUUMilltraderArrModel : NSObject
@property(nonatomic,strong)NSMutableArray <YUUMilltraderModel*> *MilltraderArr;

@end
