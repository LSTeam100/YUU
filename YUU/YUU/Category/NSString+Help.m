//
//  NSString+Help.m
//  APPHelp
//
//  Created by boli on 2018/8/7.
//  Copyright © 2018年 boli. All rights reserved.
//

#import "NSString+Help.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Help)

- (BOOL)isPhoneNumber {
    NSString* const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isNotNilOrEmpty {
    if (self == nil ||
        [self isEqualToString:@"nil"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@""])
    {
        return NO;
    }
    return YES;
}

- (NSString *)MD5 {
    if (self==nil || [self length]==0) {
        return nil;
    }
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count=0; count<CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSInteger)IntRandomLength:(NSInteger)length {
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return [randomString integerValue];
}

- (BOOL)isNumber {
    NSString *checkedNumString = self;
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

@end
