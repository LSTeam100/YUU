//
//  HLCLog.m
//  HMAdSDK
//
//  Created by troy zhao on 16/11/8.
//  Copyright © 2016年 海誉动想. All rights reserved.
//

#import "HLCLog.h"
#include <stdio.h>
#include <sys/time.h>

void writeLogToFile( NSString *logContent);
FILE * getLogFile();

void HLCLOG( NSString *format, ... ) {
    va_list args;
    va_start(args, format);
    NSString *content = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2.设置时间格式化对象的样式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS ";
    // 3.利用时间格式化对象对时间进行格式化
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    writeLogToFile( [dateStr stringByAppendingString:content] );
}

FILE * getLogFile() {
    static FILE * s_pLogFile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *logFileName = [document stringByAppendingPathComponent:@"hmad.log"];
        s_pLogFile = fopen([logFileName cStringUsingEncoding:NSUTF8StringEncoding], "a");
    });
    
    return s_pLogFile;
}

void writeLogToFile( NSString *logContent) {
    const char * clog = [logContent UTF8String];
    fwrite(clog, strlen(clog), 1, getLogFile());
    fwrite("\n", 1, 1, getLogFile());
    fflush(getLogFile());
}
