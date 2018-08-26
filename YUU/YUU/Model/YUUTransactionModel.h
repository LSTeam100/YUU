//
//  YUUTransactionModel.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface YUUTransactionModel : YUUBaseModel

@property (nonatomic, strong) NSString *number; // 单号
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *buyerId;
@property (nonatomic, strong) NSString *sellerId;

@property (nonatomic, assign) NSInteger status;

@end
