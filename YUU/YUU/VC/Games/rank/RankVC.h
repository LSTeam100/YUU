//
//  RankVC.h
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseViewController.h"
#import "RankCell.h"

typedef void(^ShowLastRankBlock)();


@interface RankVC : YUUBaseViewController

@property (nonatomic, strong) ShowLastRankBlock showLastRankBlock;

@property (nonatomic, assign) RankType rankType;

@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;

@property (strong, nonatomic) IBOutlet UIView *upView;
@property (strong, nonatomic) IBOutlet UIImageView *upIcon;
@property (strong, nonatomic) IBOutlet UILabel *upTitle;
@property (strong, nonatomic) IBOutlet UILabel *upContentLabel;
@property (strong, nonatomic) IBOutlet UIButton *lastWeekBtn;

@property (strong, nonatomic) IBOutlet UIView *middleView;
@property (strong, nonatomic) IBOutlet UILabel *middleLabel2;
@property (strong, nonatomic) IBOutlet UILabel *middleLabel3;
@property (strong, nonatomic) IBOutlet UILabel *middleLabel4;

@property (strong, nonatomic) IBOutlet YUUBaseTableView *tableVeiw;

@end
