//
//  UIDevice+YUUDe.h
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YUUDe)
+ (BOOL)isIPad;
+ (BOOL)isIPod;

+ (void)startNetworkMonitor;
+ (BOOL)isDeviceLandscape;
+ (BOOL)isIOS8;
+ (NSString *) platform;

//Mac
+ (NSString *)currentMAC;
//系统版本
+ (NSString *)systemVersionNumber;
//IP地址
+ (NSString *)localIPAddress;
//本地首选项
+ (NSString *)localLangage;
//本地
+ (NSString *)getLocal;
//运营商
+ (NSString*)getCarrierName;
/// 判断设备是否越狱, 通过能否打开Cydia来判断
+ (BOOL)isJailbroken_ad;
//网络
+ (NSString *)ReachabilityString;
+ (NSInteger)getNetworkType;
//UserAgent
+ (NSString *)getUserAgent;
+ (NSString *)deleteSpace:(NSString *)space;
+ (NSString *)ChannceReachabilityString;
+ (NSString *)getDeployerID;

// 硬件型号
+ (NSString *)hardwareModel;

//获取手机型号
+(NSString *)getPhoneType;
//IDFV
+ (NSString *)IDFAString;
@end
