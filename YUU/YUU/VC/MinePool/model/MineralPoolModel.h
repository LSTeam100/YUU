//
//  MineralPoolModel.h
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"
#import "DirectPushModel.h"
#import "TeamPushModel.h"

@interface MineralPoolModel : YUUBaseModel

@property (nonatomic, assign) NSInteger millspoolpower; // 矿池算力（Int）

@property (nonatomic, assign) NSInteger totalminers; // 总矿工数（Int）

@property (nonatomic, assign) NSInteger threeminer; // 三级矿工数（Int）

@property (nonatomic, assign) NSInteger totaldirect; // 直推人数（Int）

@property (nonatomic, assign) NSInteger twominer; // 二级矿工数（Int）

@property (nonatomic, assign) NSInteger oneminer; // 一级矿工数（Int）

@property (nonatomic, assign) NSInteger actminer; // 在产矿工数（Int）

@property (nonatomic, assign) NSInteger fourminer; // 四级矿工数（Int）

@property (nonatomic, strong) NSArray *nodirectid; // 非直推列表

@property (nonatomic, strong) NSArray *directid; // 直推列表

@end
