//
//  GamesHomeCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GamesHomeCtrl.h"
#import "OffensiveAndDefensiveOrderVC.h"
#import "GameCtrl.h"
#import "GameAttackCtrl.h"
@interface GamesHomeCtrl ()
    @property(nonatomic,weak)IBOutlet UIView *gameView;
    @property(nonatomic,weak)IBOutlet UIView *chatView;
    @property(nonatomic,weak)IBOutlet UIView *unOpenView;
    @property(nonatomic,weak)IBOutlet UIButton *gameBtn;
    @property(nonatomic,weak)IBOutlet UIButton *chatBtn;
    @property(nonatomic,weak)IBOutlet UIButton *unOpenBtn;
@end

@implementation GamesHomeCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏娱乐";
    [self.gameBtn setTitleColor:YUUYellow forState:UIControlStateNormal];
    [self.chatBtn setTitleColor:YUUYellow forState:UIControlStateNormal];
    [self.unOpenBtn setTitleColor:colorWithHexString(@"939393", 1.0) forState:UIControlStateNormal];
    
    self.gameBtn.backgroundColor = YUUYellow_alpha(0.05);
    self.chatBtn.backgroundColor = YUUYellow_alpha(0.05);
    self.unOpenBtn.backgroundColor = colorWithHexString(@"939393", 0.05);
    self.gameView.layer.cornerRadius = 10;
    self.gameView.layer.borderColor = YUUYellow.CGColor;
    self.gameView.layer.borderWidth = 1;
    self.chatView.layer.cornerRadius = 10;
    self.chatView.layer.borderColor = YUUYellow.CGColor;
    self.chatView.layer.borderWidth = 1;
    self.unOpenView.layer.cornerRadius = 10;
    self.unOpenView.layer.borderColor = [colorWithHexString(@"939393", 1.0) CGColor];
    self.unOpenView.layer.borderWidth = 1;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gameBtnAction:(UIButton *)sender {
    OffensiveAndDefensiveOrderVC *vc = [OffensiveAndDefensiveOrderVC storyboardInstanceType];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)UnOpenBtn:(UIButton *)sender{
    
    UIImage *img = [UIImage imageNamed:@"holdon"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image = img;
    [HUD showCustomView:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide];
    });

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
