//
//  TeamPushModel.h
//  YUU
//
//  Created by boli on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseModel.h"

@interface TeamPushModel : YUUBaseModel

@property (nonatomic, strong) NSString *headphoto;

@property (nonatomic, assign) NSInteger membergrade;

@property (nonatomic, assign) NSInteger memberid;

@property (nonatomic, assign) NSInteger memberpower;

@property (nonatomic, assign) NSInteger membertotalmills;

@property (nonatomic, assign) NSInteger membertotaldirect;

@property (nonatomic, assign) NSInteger membertotalnodirect;

@end
