//
//  YUUTeamInfo.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDView.h"
#import "HUDProtocol.h"
#import "MineralPoolModel.h"

@interface YUUTeamInfoView : HUDView

@property (nonatomic ,weak) id <HUDProtocol> delegate;

+ (instancetype)xibInstancetype;

@property (strong, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;

@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;

@property (nonatomic, strong) MineralPoolModel *model;

@end
