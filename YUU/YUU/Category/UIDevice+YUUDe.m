//
//  UIDevice+YUUDe.m
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIDevice+YUUDe.h"
#include <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#import "HLCNetworkReachability.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "HMWADSimulateIDFA.h"
@implementation UIDevice (YUUDe)

+ (void)startNetworkMonitor {
    [[HLCNetworkReachability sharedReachability] startMonitoring];
}

+ (NSString *)hardwareModel {
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine
                                    encoding:NSUTF8StringEncoding];
    return deviceType;
}

+ (UIWindow *)applicationRootWindow {
    //    NSArray *wins = [UIApplication sharedApplication].windows;
    //    for (int i = 0; i < wins.count; i++) {
    //        UIWindow * w = wins[i];
    //        if (w.hidden == NO && w.rootViewController) {
    //            return w;
    //        }
    //    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (BOOL)isIOS8 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0;
}

+ (BOOL)isDeviceLandscape {
    if (![NSThread isMainThread]) {
        __block BOOL ret = NO;
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
                ret = YES;
            }
        });
        return ret;
    }
    else {
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
            return YES;
        }
        else
            return NO;
    }
    
}

+ (BOOL) isIPad{
    NSString *platform=[UIDevice currentDevice].model;
    if ([[platform lowercaseString] rangeOfString:@"ipad"].length>0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPod{
    NSString *platform=[UIDevice currentDevice].model;
    if ([[platform lowercaseString] rangeOfString:@"ipod"].length>0) {
        return YES;
    }
    return NO;
}



+ (NSString *) platform{
    size_t v1; // [sp+Ch] [bp-Ch]@1
    void *v2; // [sp+10h] [bp-8h]@1
    
    sysctlbyname("hw.machine", 0, &v1, 0, 0);
    v2 = malloc(v1 + 10);
    memset(v2, 0, v1 + 10);
    sysctlbyname("hw.machine", v2, &v1, 0, 0);
    NSString* v3 = [NSString stringWithCString:(const char*)v2 encoding: NSUTF8StringEncoding];
    free(v2);
    return v3;
}

//Mac
+ (NSString *)currentMAC{
    NSString *mac = [self macAddress];
    
    if (mac) {
        return mac;
    }
    return @"";
}

+ (NSString *)macAddress{
    int                 mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    char dataBuffer[13];
    memset(dataBuffer, 0, 13);
    sprintf(dataBuffer, "%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5));
    
    NSString *outstring = [NSString stringWithCString:dataBuffer encoding:NSUTF8StringEncoding];
    free(buf);
    return outstring;
}

//+(NSString *)mlbString{
//    return [NSString stringWithCString:IOKitExtensions::mlbSerialNumber().c_str() encoding:NSUTF8StringEncoding];
//}
//
//+ (NSString *)serialNumberString{
//    return [NSString stringWithCString:IOKitExtensions::serialNumber().c_str() encoding:NSUTF8StringEncoding];
//}

//系统版本
+ (NSString *)systemVersionNumber{
    NSString *sys = [[UIDevice currentDevice] systemVersion];
    NSString *num =[NSString stringWithFormat:@"10"];
    NSArray *sysArr = [sys componentsSeparatedByString:@"."];
    if (sysArr.count > 0) {
        NSString *firstPart = [sysArr objectAtIndex:0];
        num = firstPart;
    }
    return num;
}

//IP地址
+ (NSString *)localIPAddress{
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

//本地首选项
+ (NSString *)localLangage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *localLangage = [languages objectAtIndex:0];
    
    return localLangage;
}

//本地
+ (NSString *)getLocal{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    return country;
}

//运营商
+ (NSString*)getCarrierName{
    
    static NSString *carrierCode = nil;
    if (carrierCode == nil) {
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        if (carrier == nil) {
            carrierCode = @"未获取到"; // 未取到，暂用WiFi代替
        }
        else {
            carrierCode = [carrier carrierName];
        }
        return carrierCode;
    }
    else
    {
        return carrierCode;
    }
    
    
}

/// 判断设备是否越狱, 通过能否打开Cydia来判断
+ (BOOL)isJailbroken_ad{
    BOOL jailbroken = NO;
    NSArray *jailbrokenPaths = @[
                                 @"/Applications/Cydia.app",
                                 @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                 @"/bin/bash",
                                 @"/usr/sbin/sshd",
                                 @"/etc/apt",
                                 @"/private/var/lib/apt/"];
    
    for (NSString *p in jailbrokenPaths) {
        if([[NSFileManager defaultManager] fileExistsAtPath:p]) {
            jailbroken = YES;
            //            DLOG(@"jaril 1");
            break;
        }
    }
    
    if (!jailbroken) {
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]){
            jailbroken = YES;
            //            DLOG(@"jaril 2");
        }
    }
    
    if (!jailbroken) {
        char *env = getenv("DYLD_INSERT_LIBRARIES");
        if (env) {
            jailbroken = YES;
            //            DLOG(@"jaril 3");
        }
    }
    
    return jailbroken;
    //    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]];
}

//BOOL zhutils__isJailBreak () {
//
//}


+ (NSInteger)getNetworkType {
    NSInteger ret = [HLCNetworkReachability sharedReachability].networkReachabilityStatus;
    if (ret == HLCNetworkReachabilityStatusReachableViaWWAN) {
        return [[HLCNetworkReachability sharedReachability] readioAccessType];
    }
    else {
        return ret;
    }
    return 0;
}

//网络
+ (NSString *)ReachabilityString{
    
    switch ([self getNetworkType]) {
        case HLCNetworkReachabilityStatusNotReachable:
            return @"ethernet";//无网络
            break;
        case HLCNetworkRadioAccessType2G:
        case HLCNetworkReachabilityStatusReachableViaWWAN:
            return @"2G";//2G
            break;
        case HLCNetworkRadioAccessType3G:
            return @"3G";//3G
            break;
        case HLCNetworkRadioAccessType4G:
            return @"4G";//4G
            break;
        case HLCNetworkReachabilityStatusReachableViaWiFi:
            return @"wifi";//WIFI
            break;
            
        default:
            return @"unknown";//异常
            break;
    }
    return @"unknown";//异常
}
+ (NSString *)ChannceReachabilityString{
    switch ([self getNetworkType]) {
        case HLCNetworkReachabilityStatusNotReachable:
            return @"1";//无网络
            break;
        case HLCNetworkRadioAccessType2G:
        case HLCNetworkReachabilityStatusReachableViaWWAN:
            return @"2";//2G3G
            break;
        case HLCNetworkRadioAccessType3G:
            return @"3";//2G3G
            break;
        case HLCNetworkRadioAccessType4G:
            return @"4";//2G3G
            break;
        case HLCNetworkReachabilityStatusReachableViaWiFi:
            return @"1";//WIFI
            break;
            
        default:
            return @"1";//异常
            break;
    }
    return @"1";//异常
}


//UserAgent
+ (NSString *)getUserAgent{
    static NSString *s_ua = nil;
    if (s_ua == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString *secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        if (secretAgent == nil) {
            secretAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A405 Safari/600.1.4";
        }
        s_ua = secretAgent;
    }
    
    
    return s_ua;
}

//删除空格
+ (NSString *)deleteSpace:(NSString *)space{
    NSString *str = [space stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}
+ (NSString *)getDeployerID{
    NSString *deployer = @"unknow";
    if ([[NSBundle mainBundle] bundleIdentifier]) {
        deployer = [[NSBundle mainBundle] bundleIdentifier];
        //bundleid 去掉点 去掉第一个点前面的 然后倒序
        NSArray *array = [deployer componentsSeparatedByString:@"."];
        NSString *newStr = @"";
        //有点
        if (array.count > 1) {
            for (NSInteger i = 1; i < array.count; i ++) {
                newStr = [newStr stringByAppendingString:[array objectAtIndex:i]];
            }
            deployer = newStr;
        }else{//如果没有点
            deployer = [array objectAtIndex:0];
        }
        
        //倒序
        NSMutableString *backString = [[NSMutableString alloc] initWithCapacity:deployer.length];
        for (NSInteger i = deployer.length - 1; i >=0 ; i --) {
            unichar ch = [deployer characterAtIndex:i];
            [backString appendFormat:@"%c", ch];
        }
        
        deployer = [backString copy];
    }
    
    return deployer;
}
//手机类型
+(NSString *)getPhoneType{
    NSString *platform = [UIDevice hardwareModel];
    if([platform isEqualToString:@"iPhone1,1"]){
        return @"iPhone 2G";
    }
    else if([platform isEqualToString:@"iPhone1,2"]){
        return @"iPhone 3G";
    }
    
    else if([platform isEqualToString:@"iPhone2,1"]){
         return @"iPhone 3GS";
    }
    else if([platform isEqualToString:@"iPhone3,1"]){
        return@"iPhone 4";
    }
    else if([platform isEqualToString:@"iPhone3,2"]){
        return@"iPhone 4";
    }
    else if([platform isEqualToString:@"iPhone3,3"]){
        return@"iPhone 4";
    }
    else if([platform isEqualToString:@"iPhone4,1"]){
        return@"iPhone 4S";
    }
    else if([platform isEqualToString:@"iPhone5,1"]){
        return@"iPhone 5";
    }
    else if([platform isEqualToString:@"iPhone5,2"]){
        return@"iPhone 5";
    }
    else if([platform isEqualToString:@"iPhone5,3"]){
        return@"iPhone 5c";
    }
    else if([platform isEqualToString:@"iPhone5,4"]){
        return@"iPhone 5c";
    }
    else if([platform isEqualToString:@"iPhone6,1"]){
         return@"iPhone 5s";
    }
    else if([platform isEqualToString:@"iPhone6,2"]){
        return@"iPhone 5s";
    }
    else if([platform isEqualToString:@"iPhone7,1"]){
         return@"iPhone 6Plus";
    }
    else if([platform isEqualToString:@"iPhone7,2"]){
        return@"iPhone 6";
    }
    else if([platform isEqualToString:@"iPhone8,1"]){
        return@"iPhone 6s";
    }
    else if([platform isEqualToString:@"iPhone8,2"]){
         return@"iPhone 6sPlus";
    }
    else if([platform isEqualToString:@"iPhone8,4"]){
        return@"iPhone SE";
    }
    else if([platform isEqualToString:@"iPhone9,1"]){
        return@"iPhone 7";
    }
    else if([platform isEqualToString:@"iPhone9,2"]){
        return@"iPhone 7Plus";
    }
    else if([platform isEqualToString:@"iPhone10,1"]){
        return@"iPhone 8";
    }
    else if([platform isEqualToString:@"iPhone10,4"]){
        return@"iPhone 8";
    }
    else if([platform isEqualToString:@"iPhone10,2"]){
        return@"iPhone 8Plus";
    }
    else if([platform isEqualToString:@"iPhone10,5"]){
        return@"iPhone 8Plus";
    }
    else if([platform isEqualToString:@"iPhone10,3"]){
        return@"iPhone X";
    }
    else if([platform isEqualToString:@"iPhone10,6"]){
        return@"iPhone X";
    }
    else if([platform isEqualToString:@"iPad1,1"]){
        return@"iPad 1G";
    }
    else if([platform isEqualToString:@"iPad2,1"]){
        return@"iPad 2";
    }
    else if([platform isEqualToString:@"iPad2,2"]){
        return@"iPad 2";
    }
    else if([platform isEqualToString:@"iPad2,3"]){
        return@"iPad 2";
    }
    else if([platform isEqualToString:@"iPad2,4"]){
        return@"iPad 2";
    }
    else if([platform isEqualToString:@"iPad2,5"]){
         return@"iPad Mini1G";
    }
    else if([platform isEqualToString:@"iPad2,6"]){
         return@"iPad Mini1G";
    }
    else if([platform isEqualToString:@"iPad2,7"]){
        return@"iPad Mini1G";
    }
    else if([platform isEqualToString:@"iPad3,1"]){
        return@"iPad 3";
    }
    else if([platform isEqualToString:@"iPad3,2"]){
        return@"iPad 3";
    }
    else if([platform isEqualToString:@"iPad3,3"]){
        return@"iPad 3";
    }
    else if([platform isEqualToString:@"iPad3,4"]){
        return@"iPad 4";
    }
    else if([platform isEqualToString:@"iPad3,5"]){
        return@"iPad 4";
    }
    else if([platform isEqualToString:@"iPad3,6"]){
        return@"iPad 4";
    }
    else if([platform isEqualToString:@"iPad4,1"]){
        return@"iPad Air";
    }
    else if([platform isEqualToString:@"iPad4,2"]){
        return@"iPad Air";
    }
    else if([platform isEqualToString:@"iPad4,3"]){
        return@"iPad Air";
    }
    else if([platform isEqualToString:@"iPad4,4"]){
         return@"iPad Mini2G";
    }
    else if([platform isEqualToString:@"iPad4,5"]){
        return@"iPad Mini2G";
    }
    else if([platform isEqualToString:@"iPad4,6"]){
        return@"iPad Mini2G";
    }
    else if([platform isEqualToString:@"iPad4,7"]){
        return@"iPad Mini3";
    }
    else if([platform isEqualToString:@"iPad4,8"]){
        return@"iPad Mini3";
    }
    else if([platform isEqualToString:@"iPad4,9"]){
        return@"iPad Mini3";
    }
    else if([platform isEqualToString:@"iPad5,1"]){
        return@"iPad Mini4";
    }
    else if([platform isEqualToString:@"iPad5,2"]){
        return@"iPad Mini4";
    }
    else if([platform isEqualToString:@"iPad5,3"]){
        return@"iPad Air2";
    }
    else if([platform isEqualToString:@"iPad5,4"]){
        return@"iPad Air2";
    }
    else if([platform isEqualToString:@"iPad6,3"]){
        return@"iPad Pro9.7";
    }
    else if([platform isEqualToString:@"iPad6,4"]){
        return@"iPad Pro9.7";
    }
    else if([platform isEqualToString:@"iPad6,7"]){
        return@"iPad Pro12.9";
    }
    else if([platform isEqualToString:@"iPad6,8"]){
        return@"iPad Pro12.9";
    }
    else if([platform isEqualToString:@"i386"])  {
        return@"iPhone Simulator";
    }
    else if([platform isEqualToString:@"x86_64"]){
        return@"iPhone Simulator";
    }
    else{
        return @"iPhone 7";
    }
}
//IDFA
+ (NSString *)IDFAString{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        NSString *realIDFA = [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
        if ([realIDFA isEqualToString:@"00000000-0000-0000-0000-000000000000"] || [realIDFA isEqualToString:@""]) {
            realIDFA = [HMWADSimulateIDFA createSimulateIDFA];
        }
        return realIDFA;
    }else{
        return @"";
    }
}

@end
