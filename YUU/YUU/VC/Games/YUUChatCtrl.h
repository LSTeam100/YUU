//
//  YUUChatCtrl.h
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

typedef enum {
    chatTypeNormal,
    chatTypeEmperor,
    chatTypeSuggest,
}chatType;

@interface YUUChatCtrl : YUUSuperCtrl
@property(nonatomic,assign)chatType type;
@end
