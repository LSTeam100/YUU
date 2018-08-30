//
//  YUUMachinePoolArrModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUUMachinePoolModel :NSObject
@property(nonatomic,strong)NSString *headphoto;
@property(nonatomic,strong)NSNumber *membergrade;
@property(nonatomic,strong)NSNumber *memberid;
@property(nonatomic,strong)NSNumber *memberpower;
@property(nonatomic,strong)NSNumber *membertotalmills;
@property(nonatomic,strong)NSNumber *membertotaldirect;
@property(nonatomic,strong)NSNumber *membertotalnodirect;
@property(nonatomic,strong)NSNumber *memberphone;
-(instancetype)initWtihDic:(NSDictionary *)dic;



@end


@interface YUUMachinePoolArrModel : NSObject
@property(nonatomic,strong)NSNumber *millspoolpower;
@property(nonatomic,strong)NSNumber *totalminers;
@property(nonatomic,strong)NSMutableArray <YUUMachinePoolModel*>*directidArr;
@property(nonatomic,strong)NSNumber *threeminer;
@property(nonatomic,strong)NSNumber *totaldirect;
@property(nonatomic,strong)NSNumber *twominer;
@property(nonatomic,strong)NSNumber *oneminer;
@property(nonatomic,strong)NSNumber *actminer;
@property(nonatomic,strong)NSNumber *fourminer;
@property(nonatomic,strong)NSMutableArray <YUUMachinePoolModel*>*nodirectidArr;


@end
