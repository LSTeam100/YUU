//
//  YUUMsgModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMsgModel.h"

@implementation YUUMsgModelList
-(instancetype)init{
    self = [super init];
    if (self) {
        self.msgList = [[NSMutableArray alloc]init];
    }
    return self;
}
@end

@implementation YUUMsgModel
-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.newsname = dic[@"newsname"];
        self.newstime = dic[@"newstime"];
        self.newstext = dic[@"newstext"];
    }
    return self;
}


@end
