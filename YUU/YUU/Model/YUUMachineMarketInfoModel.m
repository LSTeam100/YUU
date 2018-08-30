//
//  YUUMachineMarketInfoModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMachineMarketInfoModel.h"


@implementation machineMarketBoardModel


@end

@implementation machineMarketMemberdataModel


@end


@implementation machineMarketPriceModel


@end

@implementation machineMarketMailListModel



@end


@implementation YUUMachineMarketInfoModel

-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.tradernum = dic[@"tradernum"];
        
    }
    return self;
}
@end
