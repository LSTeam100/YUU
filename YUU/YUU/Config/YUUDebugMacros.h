//
//  YUUDebugMacros.h
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef YUUDebugMacros_h
#define YUUDebugMacros_h

#include "HLCLog.h"

#define kUserAccountKey @"__cp_account"
#define kUserPasswordKey @"__cp_password"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define kLogToFile 1        // 是否将日志写入文件， 发布时请设为0

#if (DEBUG)

/** 调试日志，release时不打印 */
#define DLOG( format, ... )        NSLog( @"<HMAds> "format, ##__VA_ARGS__ )
#define DNETLOG( format, ...)   NSLog( @"<HMAds> <Network> "format, ##__VA_ARGS__ )
#define DNETCLOG( format, ...)  printf("<HMAds> <Network> "format, ##__VA_ARGS__ ); printf("\n")

/** 打标记 arg为一个字符串 */
#define DMARK( arg )            NSLog(@"%@ ---> %@, %d, %s ", arg, [[NSString stringWithUTF8String:__FILE__] lastPathComponent]  , __LINE__, __FUNCTION__)

/** 自定义printf */
#define DPRINT( format, ... )    printf( format, ##__VA_ARGS__ ); printf("\n")
/** 自定义 assert， release时不会assert */
#define DERRLOG(format, ...)    NSLog( @"!!! <HMAds Error> >>>>>> ** ---> %@, %d, %s "format , [[NSString stringWithUTF8String:__FILE__] lastPathComponent] , __LINE__,  __FUNCTION__, ##__VA_ARGS__ ); assert(false);

//#define DLOG( format, ...)      HLCLOG( @"<HMAds> "format, ##__VA_ARGS__ )
//#define DNETLOG( format, ...)   HLCLOG( @"<HMAds> <Network> "format, ##__VA_ARGS__ )
//#define DERRLOG( format, ...)   HLCLOG( @"!!! <HMAds Error>  "format , ##__VA_ARGS__)

#else

#if kLogToFile==1

#define DLOG( format, ...)      HLCLOG( @"<HMAds> "format, ##__VA_ARGS__ )
#define DNETLOG( format, ...)   HLCLOG( @"<HMAds> <Network> "format, ##__VA_ARGS__ )
#define DERRLOG( format, ...)   HLCLOG( @"!!! <HMAds Error>  "format , ##__VA_ARGS__)
#else
#define DLOG(...)
#define DNETLOG(...)
#define DERRLOG(format, ...)
#endif

#define DNETCLOG( format, ...)
/** 自定义printf */
#define DPRINT( format, ... )    do{}while(0)

#define DMARK( arg )            do{}while(0)

#endif
#endif /* YUUDebugMacros_h */
