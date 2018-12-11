//
//  ChatMsgModel.m
//  YUU
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ChatMsgModel.h"

@implementation ChatMsgModel

-(instancetype)initWtihDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.memberId = dic[@"memberId"];
        self.membergrade = dic[@"membergrade"];
        self.calltext = dic[@"calltext"];
        self.msgId = dic[@"id"];
        self.createTime = dic[@"time"];
    }
    return self;
}

@end
