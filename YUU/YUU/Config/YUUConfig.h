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
#import "HUD.h"
#import "HUDManager.h"
#import "YUUAlertView.h"
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
NS_INLINE NSString* getLocalVerifyCodeWithBit(int num){
    NSString *verifyCode = @"";
    for (int i = 0; i < num; i++) {
        int n = (0 + arc4random() % (9 - 0 + 1));
        verifyCode = [verifyCode stringByAppendingString:[NSString stringWithFormat:@"%d",n]];
        
    }
    return verifyCode;
}
NS_INLINE void showCostomAlert(NSString * imageName ,CGRect frame){
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = img;
//    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"YUUAlertView" owner:nil options:nil];
//    YUUAlertView *cView = [nibContents lastObject];
//    cView.frame = frame;
//    [cView showYUUAlert:imageName];
    
//    [HUD showCustomView:imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide];
    });
}

NS_INLINE UIImage* getHeadPhoto(NSString * headStr){
    NSString *upgrade = @"0";
    
    if ([headStr isEqualToString:@"普通矿工"]) {
        upgrade = @"0";
    }
    else if ([headStr isEqualToString:@"一级矿工"]){
        upgrade = @"1";
    }
    else if ([headStr isEqualToString:@"二级矿工"]){
        upgrade = @"2";
    }else if ([headStr isEqualToString:@"三级矿工"]){
        upgrade = @"3";
    }
    else{
        upgrade = @"4";

    }
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"head_%@",upgrade]];
    return img;
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
NS_INLINE int isMobileValid(NSString *phoneNum){
    NSString * regexPhoneNum = @"[0－9]{11}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexPhoneNum];
    
    if ([predicate evaluateWithObject:phoneNum] == true) {
        return 1;
    }
    return 0;
}

//用户名密码正则验证：8个字符以上，由字母和数字组成
NS_INLINE int isUserPwdValid(NSString *pwd){
    if (pwd.length < 8) {
        //长度不对
        return 0;
    }
    NSString *regExp = @"[A-Za-z0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExp];
    if ([predicate evaluateWithObject:pwd] == true) {
        return 1;
    }
    return 0;
}





#endif /* YUUConfig_h */
