//
//  YUUEncryMgr.m
//  YUU
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUEncryMgr.h"
#import<CommonCrypto/CommonDigest.h>

@implementation YUUEncryMgr
+(NSString *) sha1:(NSString *)input
{
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
@end
