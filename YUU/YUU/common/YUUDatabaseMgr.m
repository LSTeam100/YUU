//
//  YUUDatabaseMgr.m
//  YUU
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUDatabaseMgr.h"
//static NSString * const defaultTableName = @"chatTable";

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
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:self.tableName];
    DLOG(@"dbPath=%@",dbPath);
    self.yuuDB = [FMDatabase databaseWithPath:dbPath];

    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:dbPath]) {
        DLOG(@"已经创建好数据库");
        return  true;
    }
    if(!self.yuuDB.open)
    {
        NSLog(@"打开数据库失败");
        return false;
    }
    else{
    BOOL result=[self.yuuDB executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_%@ (id integer PRIMARY KEY AUTOINCREMENT, memberid VARCHAR(255) NOT NULL, membergrade VARCHAR(255) NOT NULL,calltext VARCHAR(255) NOT NULL,msgid VARCHAR(255) NOT NULL,createtime VARCHAR(255) NOT NULL);",self.tableName]];
        [self.yuuDB close];
        return result;
    }
}
-(NSMutableArray *)queryMsg{
    [self isOpen];
    // 1.执行查询语句
    FMResultSet *resultSet = [self.yuuDB executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_%@",self.tableName]];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // 2.遍历结果
    while ([resultSet next]) {
        ChatMsgModel *model = [[ChatMsgModel alloc] init];
        NSString * memberid = [resultSet stringForColumn:@"memberid"];
        model.memberId = [NSNumber numberWithInt:[memberid intValue]];
        model.membergrade = [NSNumber numberWithInt:[[resultSet stringForColumn:@"membergrade"] intValue]];
        model.calltext = [resultSet stringForColumn:@"calltext"];
        model.createTime = [resultSet stringForColumn:@"createtime"];
        model.msgId = [resultSet stringForColumn:@"msgid"];
        [arr addObject:model];
    }
    return arr;
}
-(BOOL)isOpen{
    if ([self.yuuDB open]) {
        return true;
    }
    else{
        return false;
    }
}
-(BOOL)updateData:(ChatMsgModel *)model{
    if (![self isOpen]) {
        return false;
    }
    NSString *table = [NSString stringWithFormat:@"t_%@",self.tableName];
    BOOL results = [self.yuuDB executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET memberid = ? , membergrade = ? , calltext = ?, createtime = ? WHERE msgid = ?",table],model.memberId,model.membergrade,model.calltext,model.createTime,model.msgId];
    [self.yuuDB close];
    return results;
    
}
-(BOOL)insertData:(ChatMsgModel *)model{
    if (![self isOpen]) {
        return false;
    };
    NSArray *msgArr = [self queryMsg];
    BOOL isHas = false;
    for (ChatMsgModel *m in msgArr) {
        if (model.msgId == m.msgId) {
            isHas = true;
            break;
        }
    }
    BOOL results;
    if (isHas) {
       results = [self updateData:model];
        if (results) {
            DLOG(@"更新数据成功");
        }
        else{
            DLOG(@"更新数据失败");
        }
    }
    else{
        NSString *table = [NSString stringWithFormat:@"t_%@",self.tableName];
        results = [self.yuuDB executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (memberid,membergrade,calltext,msgid,createtime)VALUES(?,?,?,?,?)",table],model.memberId,model.membergrade,model.calltext,model.msgId,model.createTime];
        if (results) {
            DLOG(@"插入數據成功");
        }
        else{
            DLOG(@"插入數據失敗");
        }
    }
    [self.yuuDB close];
    return  results;
}

@end
