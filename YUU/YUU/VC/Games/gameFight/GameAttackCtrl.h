//
//  GameAttackCtrl.h
//  YUU
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"
#import "DefensiveListModel.h"

@interface GameAttackCtrl : YUUSuperCtrl
@property(nonatomic,weak)IBOutlet UIImageView *bowman;
@property(nonatomic,weak)IBOutlet UIImageView *cavalry;
@property(nonatomic,weak)IBOutlet UIImageView *infantry;

@property(nonatomic,weak)IBOutlet UIView *leftDefaultView;
@property(nonatomic,weak)IBOutlet UIView *middleDefaultView;
@property(nonatomic,weak)IBOutlet UIView *rightDefaultView;
@property(nonatomic,weak)IBOutlet UIView *waitView;
@property(nonatomic,weak)IBOutlet UIImageView *maohaoImageView;
@property(nonatomic,weak)IBOutlet UILabel *awardLabelTitle;
@property(nonatomic,weak)IBOutlet UILabel *awardLabel;
@property(nonatomic,assign)cardType leftCardType;
@property(nonatomic,assign)cardType midCardType;
@property(nonatomic,assign)cardType rightCardType;

@property (nonatomic, strong) DefensiveListModel *model;

@end
