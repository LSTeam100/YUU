//
//  HLCNetworkReachability.m
//  HaimaLiveCore
//
//  Created by troy zhao on 16/4/28.
//  Copyright © 2016年 海誉动想. All rights reserved.
//

#import "HLCNetworkReachability.h"
#import "ZHAFNetworkReachabilityManager.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "HLCDebugMacros.h"

@implementation HLCNetworkReachability {
    ZHAFNetworkReachabilityManager                    *_manager;
    NSMutableArray<HLCNetworkStatusObservedBlock>   *_maStatusObserverBlocks;
}

+ (instancetype)sharedReachability {
    static HLCNetworkReachability *g_ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_ins = [HLCNetworkReachability new];
    });
    return g_ins;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    _maStatusObserverBlocks = [NSMutableArray array];
    
    return self;
}

- (void)startMonitoring {
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    _manager = [ZHAFNetworkReachabilityManager managerForDomain:[url host]];
    
    self.networkReachabilityStatus = (NSInteger)_manager.networkReachabilityStatus;
    __weak __typeof(self)weakSelf = self;
    [_manager setReachabilityStatusChangeBlock:^(ZHAFNetworkReachabilityStatus status) {
        DLOG(@"netstatus change %ld", (long)status);
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = (NSInteger)status;
        [strongSelf sendStatusChangeNotification:(NSInteger)status];
        
    }];
    [_manager startMonitoring];
}

- (BOOL)isReachable {
    return [_manager isReachableViaWWAN] || [_manager isReachableViaWiFi];
}

- (void)sendStatusChangeNotification:(HLCNetworkReachabilityStatus)s {
    for (HLCNetworkStatusObservedBlock block in _maStatusObserverBlocks) {
        block( s );
    }
}

- (void)addNetworkStatusObservedBlock:(void (^)(HLCNetworkReachabilityStatus))changeObserverBlock {
    [_maStatusObserverBlocks addObject:changeObserverBlock];
}

- (void)removeNetworkStatusObservedBlock:(HLCNetworkStatusObservedBlock)block {
    NSParameterAssert(block);
    [_maStatusObserverBlocks removeObject:block];
}

- (HLCNetworkRadioAccessType)readioAccessType {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        static NSString *currentRadioAccessTechnology = nil;
        if (!currentRadioAccessTechnology) {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            currentRadioAccessTechnology = info.currentRadioAccessTechnology;
        }
        
        if (currentRadioAccessTechnology && currentRadioAccessTechnology.length) {
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                return HLCNetworkRadioAccessType4G;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                return HLCNetworkRadioAccessType2G;
            } else {
                return HLCNetworkRadioAccessType3G;
            }
        }
        else {
            return HLCNetworkRadioAccessTypeWWAN;
        }
    }
    else {
        return HLCNetworkRadioAccessTypeWWAN;
    }
}

@end
