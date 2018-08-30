//
//  YUUMsgModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YUUMsgModel;
@interface YUUMsgModelList : NSObject
@property(nonatomic,strong)NSMutableArray<YUUMsgModel*>*msgList;
@end

@interface YUUMsgModel : NSObject
-(instancetype)initWtihDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *newstime;
@property(nonatomic,strong)NSString *newsname;
@property(nonatomic,strong)NSString *newstext;
@end
