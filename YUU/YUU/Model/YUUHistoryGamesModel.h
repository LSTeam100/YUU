//
//  YUUHistoryGamesModel.h
//  YUU
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUHistoryGamesModel : NSObject
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSNumber *otherid;
@property(nonatomic,strong)NSNumber *attordef;
@property(nonatomic,strong)NSNumber *firstbout;
@property(nonatomic,strong)NSNumber *firstgetyuu;
@property(nonatomic,strong)NSNumber *firstboutintegral;
@property(nonatomic,strong)NSNumber *secondbout;
@property(nonatomic,strong)NSNumber *secondgetyuu;
@property(nonatomic,strong)NSNumber *secondboutintegral;
@property(nonatomic,strong)NSNumber *thirdbout;
@property(nonatomic,strong)NSNumber *thirdgetyuu;
@property(nonatomic,strong)NSNumber *thirdboutintegral;
@property(nonatomic,strong)NSString *HistoryGamesId;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
