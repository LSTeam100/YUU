//
//  DefensiveListModel.h
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface DefensiveListModel : YUUBaseModel

@property (nonatomic, assign) NSInteger memberid; // 用户id（int）
@property (nonatomic, assign) NSInteger membergrade; // 用户等级（int）
@property (nonatomic, assign) float putyuu; // 放了多少yuu（浮点数，小数点后只保留2位，小数点后末尾为0时0不显示）
@property (nonatomic, assign) NSInteger battlenum; // 战斗单号

@end
