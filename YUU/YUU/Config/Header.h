//
//  Header.h
//  YUU
//
//  Created by boli on 2018/8/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import "YUUColor.h"
#import "HUD.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

typedef NS_ENUM(NSInteger, UserLevel) {
    UserLevelNovice = 0, // 新手
    UserLevelAdvanced = 1, // 进阶
    UserLevelMaster = 2, // 高手
    UserLevelInternational = 3, // 国际
};

#endif /* Header_h */
