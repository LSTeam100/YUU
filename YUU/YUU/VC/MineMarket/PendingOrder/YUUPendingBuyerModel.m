//
//  YUUPendingBuyerModel.m
//  YUU
//
//  Created by boli on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingBuyerModel.h"

@implementation YUUPendingBuyerModel

- (NSString *)memberidStr {
    NSString *str = [NSString stringWithFormat:@"%ld",(long)self.memberid];
    NSString *result = @"";
    if (str.length >2) {
        for (int i = 0; i<str.length; i++) {
            if (i == 0 || i == str.length-1) {
                result = [result stringByAppendingString:[str substringWithRange:NSMakeRange(i, 1)]];
            } else {
                result = [result stringByAppendingString:@"*"];
            }
        }
    }
    return  result;
}

@end
