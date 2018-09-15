//
//  NSString+Help.h
//  APPHelp
//
//  Created by boli on 2018/8/7.
//  Copyright © 2018年 boli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Help)

- (BOOL)isPhoneNumber;

- (BOOL)isNotNilOrEmpty;

+ (NSInteger)IntRandomLength:(NSInteger)length;

- (BOOL)isNumber;

@end
