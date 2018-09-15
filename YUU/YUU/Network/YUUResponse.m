//
//  YUUResponse.m
//  YUU
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUResponse.h"

@implementation YUUResponse
-(BOOL) isSucceed{
    BOOL suc = false;
    if ([self.success intValue] == 1) {
        suc = true;
    }
    else{
        suc = false;
    }
    return suc;
}

@end
