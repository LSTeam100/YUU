//
//  DefensiveVC.m
//  YUU
//
//  Created by boli on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "DefensiveVC.h"
#import "GameYUUListVC.h"
#import "DefensiveListVC.h"

@interface DefensiveVC ()

@property (strong, nonatomic) IBOutlet UIView *view0;
@property (strong, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) IBOutlet UIImageView *icon0;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UIImageView *icon1;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UIImageView *icon2;



@end

@implementation DefensiveVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view0.backgroundColor = [UIColor clearColor];
    _view0.layer.cornerRadius = 5;
    _view0.layer.masksToBounds = YES;
    _view0.layer.borderWidth = 1;
    _view0.layer.borderColor = [UIColor R:172 G:122 B:90].CGColor;
    _label0.textColor = [UIColor R:172 G:122 B:90];

    _view1.backgroundColor = [UIColor clearColor];
    _view1.layer.cornerRadius = 5;
    _view1.layer.masksToBounds = YES;
    _view1.layer.borderWidth = 1;
    _view1.layer.borderColor = [UIColor R:182 G:209 B:208].CGColor;
    _label1.textColor = [UIColor R:182 G:209 B:208];
    
    _view2.backgroundColor = [UIColor clearColor];
    _view2.layer.cornerRadius = 5;
    _view2.layer.masksToBounds = YES;
    _view2.layer.borderWidth = 1;
    _view2.layer.borderColor = [UIColor R:240 G:59 B:70].CGColor;
    _label2.textColor = [UIColor R:240 G:59 B:70];
    
    if (_isDefensive) {
        _icon0.image = [UIImage imageNamed:@""];
        _icon1.image = [UIImage imageNamed:@""];
        _icon2.image = [UIImage imageNamed:@""];
    } else {
        _icon0.image = [UIImage imageNamed:@""];
        _icon1.image = [UIImage imageNamed:@""];
        _icon2.image = [UIImage imageNamed:@""];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action0:(id)sender {
    if (_isDefensive) {
        GameYUUListVC *vc = [GameYUUListVC storyboardInstanceType];
        vc.YUU = 0;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        DefensiveListVC *vc = [DefensiveListVC storyboardInstanceType];
        vc.YUU = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)action1:(id)sender {
    if (_isDefensive) {
        GameYUUListVC *vc = [GameYUUListVC storyboardInstanceType];
        vc.YUU = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}

- (IBAction)action2:(id)sender {
    if (_isDefensive) {
        GameYUUListVC *vc = [GameYUUListVC storyboardInstanceType];
        vc.YUU = 2;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}


@end
