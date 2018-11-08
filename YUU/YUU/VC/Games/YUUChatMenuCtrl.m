//
//  YUUChatMenuCtrl.m
//  YUU
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatMenuCtrl.h"
#import "YUUChatCtrl.h"
@interface YUUChatMenuCtrl ()
    @property(nonatomic,weak)IBOutlet UIView *normalView;
    @property(nonatomic,weak)IBOutlet UIView *emperorView;
    @property(nonatomic,weak)IBOutlet UIView *suggestView;
    @property(nonatomic,weak)IBOutlet UIButton *normalBtn;
    @property(nonatomic,weak)IBOutlet UIButton *emperorBtn;
    @property(nonatomic,weak)IBOutlet UIButton *suggestBtn;
@end

@implementation YUUChatMenuCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"畅所欲言";
    self.normalView.backgroundColor = colorWithHexString(@"52B2C6", 0.05);
    [self.normalBtn setTitleColor:colorWithHexString(@"52B2C6", 1) forState:UIControlStateNormal];
    self.normalView.layer.borderWidth = 1.0;
    self.normalView.layer.borderColor = [colorWithHexString(@"52B2C6", 1) CGColor];
    self.normalView.layer.cornerRadius = 10;
    
    self.emperorView.backgroundColor = colorWithHexString(@"B77C29", 0.05);
    [self.emperorBtn setTitleColor:colorWithHexString(@"B77C29", 1) forState:UIControlStateNormal];
    self.emperorView.layer.borderWidth = 1.0;
    self.emperorView.layer.borderColor = [colorWithHexString(@"B77C29", 1) CGColor];
    self.emperorView.layer.cornerRadius = 10;
    
    self.suggestView.backgroundColor = colorWithHexString(@"F43640", 0.05);
    [self.suggestBtn setTitleColor:colorWithHexString(@"F43640", 1) forState:UIControlStateNormal];
    self.suggestView.layer.borderWidth = 1.0;
    self.suggestView.layer.borderColor = [colorWithHexString(@"F43640", 1) CGColor];
    self.suggestView.layer.cornerRadius = 10;

    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Normal"]) {
        YUUChatCtrl *chat = segue.destinationViewController;
        chat.type = chatTypeNormal;
      
    }
    else if ([segue.identifier isEqualToString:@"Emperor"]) {
        YUUChatCtrl *chat = segue.destinationViewController;
        chat.type = chatTypeEmperor;
    }
    else if ([segue.identifier isEqualToString:@"Suggest"]) {
        YUUChatCtrl *chat = segue.destinationViewController;
        chat.type = chatTypeSuggest;
    }
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
