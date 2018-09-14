//
//  YUUMineMachineCell.h
//  YUU
//
//  Created by boli on 2018/8/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseTableViewCell.h"
#import "YUUMachineArrModel.h"

@interface YUUMineMachineCell : YUUBaseTableViewCell

@property (nonatomic, strong) YUUMachineDetailModel *model;


@property (strong, nonatomic) IBOutlet UIView *statusView;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *operationLabel;
@property (strong, nonatomic) IBOutlet UILabel *powerLabel;
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;
@property (strong, nonatomic) IBOutlet UILabel *receiveLabel;



@end
