//
//  YUUModifyPassword.h
//  YUU
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

typedef enum {
    loginType,
    transactionType,
}ModifyType;

@interface YUUModifyPassword : YUUSuperCtrl

@property(nonatomic,assign)ModifyType modifyType;
@end
