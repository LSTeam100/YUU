//
//  EnterGameVC.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "EnterGameVC.h"
#import "DefensiveVC.h"

@interface EnterGameVC ()
@property (strong, nonatomic) IBOutlet UIView *upView;
@property (strong, nonatomic) IBOutlet UIView *downView;


@end

@implementation EnterGameVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _upView.backgroundColor = [UIColor clearColor];
    _upView.layer.masksToBounds = YES;
    _upView.layer.cornerRadius = 8;
    _upView.layer.borderWidth = 1;
    _upView.layer.borderColor = [UIColor R:62 G:140 B:157].CGColor;
    
    _downView.backgroundColor = [UIColor clearColor];
    _downView.layer.masksToBounds = YES;
    _downView.layer.cornerRadius = 8;
    _downView.layer.borderWidth = 1;
    _downView.layer.borderColor = [UIColor R:186 G:119 B:41].CGColor;
}

- (IBAction)upAction:(id)sender {
    DefensiveVC *vc = [DefensiveVC storyboardInstanceType];
    vc.isDefensive = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)downAction:(id)sender {
    DefensiveVC *vc = [DefensiveVC storyboardInstanceType];
    vc.isDefensive = NO;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
