//
//  YUUCurrencyHistoryModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUCurrencyHistoryModel : NSObject
@property(nonatomic,strong)NSString *coinsite;
@property(nonatomic,strong)NSNumber *coinnum;
@property(nonatomic,strong)NSString *cointime;
-(instancetype)initWtihDic:(NSDictionary *)dic;

@end

@interface YUUCurrencyHistoryArrModel : NSObject
@property(nonatomic,strong)NSMutableArray <YUUCurrencyHistoryModel *>*currencyHistoryArr;

@end

