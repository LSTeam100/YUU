//
//  ChatMsgModel.h
//  YUU
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMsgModel : NSObject
@property(nonatomic,strong)NSNumber *memberId;
@property(nonatomic,strong)NSNumber *membergrade;
@property(nonatomic,strong)NSString *calltext;
@property(nonatomic,strong)NSString *msgId;
@property(nonatomic,strong)NSString *createTime;
-(instancetype)initWtihDic:(NSDictionary *)dic;
@end
