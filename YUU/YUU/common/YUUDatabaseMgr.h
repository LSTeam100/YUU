//
//  YUUDatabaseMgr.h
//  YUU
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "ChatMsgModel.h"

@interface YUUDatabaseMgr : NSObject
@property(nonatomic,strong)FMDatabase *yuuDB;
-(BOOL)insertData:(ChatMsgModel *)model;
-(NSMutableArray *)queryMsg;
+ (instancetype)shareInstance;
- (BOOL)openDB;
@end
