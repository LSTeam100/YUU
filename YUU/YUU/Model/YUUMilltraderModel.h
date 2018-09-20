//
//  YUUMilltraderModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YUUMilltraderModel : NSObject
@property(nonatomic,strong)NSNumber *compower; // 矿机算力
@property(nonatomic,strong)NSNumber *totaldays; // 总运行天数
@property(nonatomic,strong)NSNumber *totalcoins; // 总收益量
@property(nonatomic,strong)NSNumber *millprice; // 价格
@property(nonatomic,assign) YUUMilltype milltype; // 矿机等级0：新手1:青铜2：白银3：黄金4：铂金5：钻石
- (NSString *)typeName;
- (NSString *)iconName;

-(instancetype)initWtihDic:(NSDictionary *)dic;
@end

@interface YUUMilltraderArrModel : NSObject
@property(nonatomic,strong)NSMutableArray <YUUMilltraderModel*> *MilltraderArr;

@end
