//
//  YUUBillModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUBillModel : NSObject
@property(nonatomic,strong)NSString *billname;
@property(nonatomic,strong)NSNumber *billnum;
@property(nonatomic,strong)NSString *billtime;
@property(nonatomic,strong)NSNumber *billtype;
-(instancetype)initWtihDic:(NSDictionary *)dic;
@end

@interface YUUBillModelList : NSObject
@property(nonatomic,strong)NSMutableArray <YUUBillModel*> *billModelArr;

@end

