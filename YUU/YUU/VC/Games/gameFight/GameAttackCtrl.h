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

@property (strong, nonatomic) IBOutlet UIImageView *imageView0;
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;

@property (strong, nonatomic) IBOutlet UIImageView *imageView3;
@property (strong, nonatomic) IBOutlet UIImageView *imageView4;
@property (strong, nonatomic) IBOutlet UIImageView *imageView5;

@property (strong, nonatomic) IBOutlet UIImageView *resultImage0;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage1;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage2;


@end
