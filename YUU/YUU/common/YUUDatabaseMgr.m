//
//  YUUDatabaseMgr.m
//  YUU
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUDatabaseMgr.h"
static NSString * const defaultTableName = @"chatTable";
@implementation YUUDatabaseMgr

+ (instancetype)shareInstance{
    static YUUDatabaseMgr *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [YUUDatabaseMgr new];
    });
    return mgr;
}

- (BOOL)openDB{
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:defaultTableName];
    DLOG(@"dbPath=%@",dbPath);
    self.yuuDB = [FMDatabase databaseWithPath:dbPath];
    if(!self.yuuDB.open)
    {
        NSLog(@"打开数据库失败");
        return false;
    }
    else{
    BOOL result=[self.yuuDB executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_%@ (id integer PRIMARY KEY AUTOINCREMENT, memberid text NOT NULL, membergrade integer NOT NULL,calltext text NOT NULL,msgid text NOT NULL,createtime text NOT NULL);",defaultTableName]];
        return result;
    }
}
-(NSMutableArray *)queryMsg{
    // 1.执行查询语句
    FMResultSet *resultSet = [self.yuuDB executeQuery:@"SELECT * FROM t_chatTable"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // 2.遍历结果
    while ([resultSet next]) {
        ChatMsgModel *model = [[ChatMsgModel alloc] init];
        NSString * memberid = [resultSet stringForColumn:@"memberid"];
        model.memberId = [NSNumber numberWithInt:[memberid intValue]];
        model.membergrade = [NSNumber numberWithInteger:[resultSet intForColumn:@"membergrade"]];
        model.calltext = [resultSet stringForColumn:@"calltext"];
        model.createTime = [resultSet stringForColumn:@"createtime"];
        model.msgId = [resultSet stringForColumn:@"msgid"];
        [arr addObject:model];
    }
    return arr;
}
-(BOOL)isOpen{
    if (self.yuuDB.open) {
        [self.yuuDB beginTransaction];
        return true;
    }
    else{
        return false;
    }
}
-(BOOL)insertData:(ChatMsgModel *)model{
    if (![self isOpen]) {
        return false;
    };
    NSString *sqrStr = [NSString stringWithFormat:@"INSERT INTO t_chatTable ('%@','%ld', '%@','%@','%@') VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%@",model.memberId],(long)[model.membergrade integerValue],model.calltext,model.msgId,model.createTime];
    BOOL results = [self.yuuDB executeUpdate:sqrStr];
    return  results;
}

@end
