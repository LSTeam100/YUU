//
//  YUUChatCtrl.h
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

typedef NS_ENUM(NSInteger , chatType)  {
    chatTypeNormal = 0,
    chatTypeEmperor = 1,
    chatTypeSuggest = 2,
};

@interface YUUChatCtrl : YUUSuperCtrl
@property(nonatomic,assign)chatType type;
@end
