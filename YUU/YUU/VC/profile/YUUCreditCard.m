//
//  YUUCreditCard.m
//  YUU
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCreditCard.h"

@interface YUUCreditCard ()
@property(nonatomic,weak)IBOutlet UILabel *cardName;
@property(nonatomic,weak)IBOutlet UILabel *cardType;
@property(nonatomic,weak)IBOutlet UILabel *firstLabel;
@property(nonatomic,weak)IBOutlet UILabel *secLabel;
@property(nonatomic,weak)IBOutlet UILabel *tirdtLabel;
@property(nonatomic,weak)IBOutlet UILabel *lastLabel;
@property(nonatomic,weak)IBOutlet UILabel *cranOwnerLabel;


@end

@implementation YUUCreditCard

- (void)viewDidLoad {
    [super viewDidLoad];
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
