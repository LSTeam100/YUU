//
//  YUUMachineMarketInfoModel.h
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface machineMarketBoardModel : NSObject
@property(nonatomic,strong)NSString *tradingcard;
@property(nonatomic,strong)NSString *tradingtime;
@property(nonatomic,strong)NSNumber *memberid;
@property(nonatomic,strong)NSNumber *coinnum;
@property(nonatomic,strong)NSNumber *buyprice;
@property(nonatomic,strong)NSNumber *uporderstype;

@end

@interface machineMarketMemberdataModel : NSObject
@property(nonatomic,strong)NSString *membername;
@property(nonatomic,strong)NSString *bankname;
@property(nonatomic,strong)NSString *bankcard;
@property(nonatomic,strong)NSString *memberwx;
@property(nonatomic,strong)NSString *memberalipay;
@property(nonatomic,strong)NSString *memberphone;
@property(nonatomic,strong)NSString *memberwallet;

@end


@interface machineMarketPriceModel : NSObject
@property(nonatomic,strong)NSNumber *tradernum;
@property(nonatomic,strong)NSNumber *oneprice;
@property(nonatomic,strong)NSNumber *twoprice;
@property(nonatomic,strong)NSNumber *threeprice;
@property(nonatomic,strong)NSNumber *fourprice;
@property(nonatomic,strong)NSNumber *fiveprice;
@property(nonatomic,strong)NSNumber *sixprice;
@property(nonatomic,strong)NSNumber *sevenprice;
@property(nonatomic,strong)NSMutableArray <machineMarketMemberdataModel *>*memberdataArr;
@property(nonatomic,strong)NSNumber *tradingtype;

@end

@interface machineMarketMailListModel : NSObject
@property(nonatomic,strong)NSString *tradingcard;
@property(nonatomic,strong)NSString *tradingtime;
@property(nonatomic,strong)NSNumber *sellorbuy;
@property(nonatomic,strong)NSNumber *sorbid;
@property(nonatomic,strong)NSNumber *coinnum;
@property(nonatomic,strong)NSNumber *progressnum;


@end


@interface YUUMachineMarketInfoModel : NSObject
@property(nonatomic,strong)NSNumber *tradernum;
@property(nonatomic,strong)NSMutableArray <machineMarketPriceModel*> *lotspriceArr;
@property(nonatomic,strong)NSMutableArray <machineMarketMailListModel*> *mailArr;
@property(nonatomic,strong)NSMutableArray <machineMarketBoardModel*> *seeupordersArr;
-(instancetype)initWtihDic:(NSDictionary *)dic;


@end


