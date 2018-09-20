//
//  YUUPriceModel.h
//  YUU
//
//  Created by boli on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface YUUPriceModel : YUUBaseModel

@property (nonatomic, assign) NSInteger tradernum; // 交易次数（Int）
@property (nonatomic, strong) NSNumber *oneprice; // 最近七日第一日价格（Double）
@property (nonatomic, strong) NSNumber *twoprice; // 最近七日第二日价格（Double）
@property (nonatomic, strong) NSNumber *threeprice; // 最近七日第三日价格（Double）
@property (nonatomic, strong) NSNumber *fourprice; // 最近七日第四日价格（Double）
@property (nonatomic, strong) NSNumber *fiveprice; // 最近七日第五日价格（Double）
@property (nonatomic, strong) NSNumber *sixprice; // 最近七日第六日价格（Double）
@property (nonatomic, strong) NSNumber *sevenprice; // 最近七日第七日价格（Double）也是最新价格
@property (nonatomic, strong) NSNumber *thistime; //返回当前的时间戳（单位毫秒）

@end
