//
//  YUUConfig.h
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef YUUConfig_h
#define YUUConfig_h
#import <UIKit/UIKit.h>
#import "YUUEncryMgr.h"
#define AFHTTPSessionManager ZHAFHTTPSessionManager
#define AFHTTPRequestSerializer ZHAFHTTPRequestSerializer
#define AFJSONRequestSerializer ZHAFJSONRequestSerializer
#define AFJSONResponseSerializer ZHAFJSONResponseSerializer
#define AFHTTPResponseSerializer ZHAFHTTPResponseSerializer
#define AFURLSessionManager ZHAFURLSessionManager
#define AFNetworkReachabilityManager ZHAFNetworkReachabilityManager


#define MD5KEY @"7372d98e44d163e2ae7978a9b9d826a1"



NS_INLINE id getSignFromParameter(NSArray *paraArr){
    if (paraArr.count > 0) {
        NSArray *sordArr = [paraArr sortedArrayUsingSelector:@selector(compare:)];
        NSString *appendingStr = [sordArr componentsJoinedByString:@""];
        NSString *key = [MD5KEY stringByAppendingString:appendingStr];
        NSString *sha1key = [[YUUEncryMgr sha1:key] uppercaseString];
        return sha1key;
    }
    else{
        return nil;
    }
}





NS_INLINE id colorWithHexString(NSString *color,float costomAlpha)
{
    //ff9c00
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:costomAlpha];
}

#endif /* YUUConfig_h */
