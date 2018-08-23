//
//  YUUMineMarketVC.m
//  YUU
//
//  Created by boli on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUMineMarketVC.h"
#import "SHSegmentView.h"
#import "Header.h"
#import "YUUButton.h"


@interface YUUMineMarketVC () 

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn0;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn1;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn2;
@property (strong, nonatomic) IBOutlet YUUButton *pendingOrderBtn3;


@end

@implementation YUUMineMarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSegment];
    [self setButtonStyle];
}

- (void)addSegment {
    SHSegmentView *segment = [[SHSegmentView alloc] init];
    [self.view addSubview:segment];
    WeakSelf
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(263);
        make.height.mas_equalTo(38);
    }];
    
    [segment setSegmentTitles:@[@"价格", @"点对点", @"信箱"] segmentSelectedAtIndex:^(NSInteger index) {
        
    }];
}

- (void)setButtonStyle {
    [_pendingOrderBtn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn0.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pendingOrderBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pendingOrderBtn3.titleLabel.font = [UIFont systemFontOfSize:15];
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


- (IBAction)pendingOrderBtnAction:(id)sender {
}



@end
