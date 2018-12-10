//
//  YUUAttackResponseModel.h
//  YUU
//
//  Created by boli on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUUAttackResponseModel : YUUBaseModel

@property (nonatomic, assign) NSInteger firstbout;
@property (nonatomic, assign) NSInteger secondbout;
@property (nonatomic, assign) NSInteger thirdbout;

@property (nonatomic, assign) double firstboutgetyuu;
@property (nonatomic, assign) double secondboutgetyuu;
@property (nonatomic, assign) double thirdboutgetyuu;

@end

NS_ASSUME_NONNULL_END
