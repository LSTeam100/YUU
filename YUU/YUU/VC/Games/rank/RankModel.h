//
//  RankModel.h
//  YUU
//
//  Created by boli on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface RankModel : YUUBaseModel

@property (nonatomic, assign) NSInteger memberid; // 用户id（int）
@property (nonatomic, assign) float getyuu; //预计获得yuu数值（float）
@property (nonatomic, assign) float weekintegral; // 本周目前积分（float）

@end
