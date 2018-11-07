//
//  YUUChatCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatCtrl.h"

@interface YUUChatCtrl ()

@end

@implementation YUUChatCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"畅所欲言";
    
    if (self.type == chatTypeNormal) {
        DLOG(@"这是普通聊天区");
    }
    else if (self.type == chatTypeEmperor){
        DLOG(@"这是帝王聊天区");
    }
    else if (self.type == chatTypeSuggest){
        DLOG(@"这是建议区");
    }
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
