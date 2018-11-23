//
//  GameAttackCtrl.h
//  YUU
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"

@interface GameAttackCtrl : YUUSuperCtrl
@property(nonatomic,weak)IBOutlet UIImageView *bowman;
@property(nonatomic,weak)IBOutlet UIImageView *cavalry;
@property(nonatomic,weak)IBOutlet UIImageView *infantry;

@property(nonatomic,weak)IBOutlet UIView *leftDefaultView;
@property(nonatomic,weak)IBOutlet UIView *middleDefaultView;
@property(nonatomic,weak)IBOutlet UIView *rightDefaultView;
@property(nonatomic,weak)IBOutlet UIView *waitView;
@property(nonatomic,weak)IBOutlet UIImageView *maohaoImageView;

@end
