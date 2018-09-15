//
//  YUUPendingOrderVC.h
//  YUU
//
//  Created by boli on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseViewController.h"

@interface YUUPendingOrderVC : YUUBaseViewController


@property (strong, nonatomic) IBOutlet UILabel *upLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *myPrice;

@property (strong, nonatomic) IBOutlet UISlider *priceSlider;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (strong, nonatomic) IBOutlet UIButton *noticeBtn;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableView;


@end
