//
//  YUUForgetCtrl.h
//  YUU
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

typedef enum {
    forgetLoginType,
    forgetTransactionType,
}forgetPasswordType;

@interface YUUForgetCtrl : YUUSuperCtrl
@property(nonatomic,assign)forgetPasswordType forgetType;
@end
