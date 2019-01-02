//
//  YUUHistoryGamesModel.m
//  YUU
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUHistoryGamesModel.h"

@implementation YUUHistoryGamesModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.firstgetyuu = dic[@"firstgetyuu"];
        self.firstbout = dic[@"firstbout"];
        self.firstboutintegral = dic[@"firstboutintegral"];
        self.attordef = dic[@"attordef"];
        self.secondgetyuu = dic[@"secondgetyuu"];
        self.secondboutintegral = dic[@"secondboutintegral"];
        self.otherid = dic[@"otherid"];
        self.time = dic[@"time"];
        self.thirdboutintegral = dic[@"thirdboutintegral"];
        self.thirdgetyuu = dic[@"thirdgetyuu"];
        self.thirdbout = dic[@"thirdbout"];
        self.HistoryGamesId = dic[@"id"];
        self.secondbout = dic[@"secondbout"];
    }
    return self;
}
@end
