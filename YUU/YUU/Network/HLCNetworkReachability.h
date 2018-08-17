//
//  HLCNetworkReachability.h
//  HaimaLiveCore
//
//  Created by troy zhao on 16/4/28.
//  Copyright © 2016年 海誉动想. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HLCNetworkReachabilityStatus) {
    HLCNetworkReachabilityStatusUnknown          = -1,
    HLCNetworkReachabilityStatusNotReachable     = 0,
    HLCNetworkReachabilityStatusReachableViaWWAN = 1,
    HLCNetworkReachabilityStatusReachableViaWiFi = 2,
};

typedef NS_ENUM(NSInteger, HLCNetworkRadioAccessType) {
    HLCNetworkRadioAccessTypeWWAN = 1,
    HLCNetworkRadioAccessType2G = 3,
    HLCNetworkRadioAccessType3G,
    HLCNetworkRadioAccessType4G,
    
};

typedef void(^HLCNetworkStatusObservedBlock)(HLCNetworkReachabilityStatus s);


@interface HLCNetworkReachability : NSObject

/**
 The current network reachability status.
 */
@property (nonatomic, assign) HLCNetworkReachabilityStatus networkReachabilityStatus;

/**
 Whether or not the network is currently reachable.
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

+ (instancetype)sharedReachability;

- (void)startMonitoring;
- (void)addNetworkStatusObservedBlock:(HLCNetworkStatusObservedBlock)changeObserverBlock;
- (void)removeNetworkStatusObservedBlock:(HLCNetworkStatusObservedBlock)block;
- (HLCNetworkRadioAccessType)readioAccessType;

@end
