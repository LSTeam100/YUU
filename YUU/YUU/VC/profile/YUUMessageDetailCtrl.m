//
//  YUUMessageDetailCtrl.m
//  YUU
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMessageDetailCtrl.h"

@interface YUUMessageDetailCtrl ()
@property (nonatomic,strong) IBOutlet UILabel *contentLabel;
@end

@implementation YUUMessageDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.msgModel.newsname;
    self.contentLabel.text = self.msgModel.newstext;
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
