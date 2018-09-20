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
#import "UIColor+Help.h"
#import "HUD.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

typedef NS_ENUM(NSInteger, UserLevel) {
    UserLevelNovice = 0, // 新手
    UserLevelAdvanced = 1, // 进阶
    UserLevelMaster = 2, // 高手
    UserLevelInternational = 3, // 国际
};

typedef NS_ENUM(NSInteger, YUUMilltype) {
    YUUMilltypeNovice = 0, // 新手
    YUUMilltypebronze = 1, // 青铜
    YUUMilltypesilver = 2, // 白银
    YUUMilltypegold = 3, // 黄金
    YUUMilltypePlatinum = 4, // 铂金
    YUUMilltypediamond = 5, // 钻石
};


typedef NS_ENUM(NSUInteger, YUUMachineStatus) {
    YUUMachineStatusDefault = 0, // 已停机
    YUUMachineStatusWorking = 1, // 在产
};



typedef NS_ENUM(NSInteger, YUUMachineReceiveStatus) {
    YUUMachineReceiveDefault = 0, // 非领取的矿机（购买的）
    YUUMachineReceiveNo = 1, // 未领取
    YUUMachineReceived = 2, // 已领取
};

#endif /* Header_h */
