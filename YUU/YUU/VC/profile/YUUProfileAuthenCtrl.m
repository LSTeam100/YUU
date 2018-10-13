//
//  YUUProfileAuthenCtrl.m
//  YUU
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUProfileAuthenCtrl.h"
#import "YUUMineDetailModel.h"
#import "YUUCommonModel.h"
@interface YUUProfileAuthenCtrl ()
@property(nonatomic,weak)IBOutlet UIView *alreadyAuthenView;
@property(nonatomic,weak)IBOutlet UILabel *nameLabel;
@property(nonatomic,weak)IBOutlet UILabel *idLabel;
@property(nonatomic,weak)IBOutlet UIImageView *headImageView;

@end

@implementation YUUProfileAuthenCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.nameLabel.text = self.DetailModel.membername;
    if (self.DetailModel.memberphone == nil) {
        self.idLabel.text = [NSString stringWithFormat:@"%@",[YUUUserData shareInstance].userModel.memberid];
    }
    else{
        self.idLabel.text = [NSString stringWithFormat:@"%@",self.DetailModel.memberphone];
    }
    
    YUUCommonModel *model =[YUUUserData shareInstance].userModel;
    self.headImageView.image = getHeadPhoto(model.membergrade);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
