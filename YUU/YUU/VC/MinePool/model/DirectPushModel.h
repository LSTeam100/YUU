//
//  DirectPushModel.h
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface DirectPushModel : YUUBaseModel

@property (nonatomic, strong) NSString *headphoto;

@property (nonatomic, assign) NSInteger membergrade;

@property (nonatomic, assign) NSInteger memberid;

@property (nonatomic, assign) NSInteger memberpower; // 个人算力（Int）

@property (nonatomic, assign) NSInteger membertotalmills; // 个人矿机数（Int）

@property (nonatomic, assign) NSInteger membertotaldirect; // 个人直推数（Int）

@property (nonatomic, assign) NSInteger membertotalnodirect; // 个人团队数（Int）

@property (nonatomic, assign) NSInteger memberphone; // 个人手机号

@end
