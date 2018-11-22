//
//  GameCtrl.h
//  YUU
//
//  Created by apple on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUSuperCtrl.h"
@interface GameCtrl : YUUSuperCtrl
@property(nonatomic,weak)IBOutlet UIImageView *bowman;
@property(nonatomic,weak)IBOutlet UIImageView *cavalry;
@property(nonatomic,weak)IBOutlet UIImageView *infantry;

@property(nonatomic,weak)IBOutlet UIView *leftDefaultView;
@property(nonatomic,weak)IBOutlet UIView *middleDefaultView;
@property(nonatomic,weak)IBOutlet UIView *rightDefaultView;
@property(nonatomic,weak)IBOutlet UIView *waitView;
@end
