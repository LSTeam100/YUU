//
//  YUUPendingNoticeVC.m
//  YUU
//
//  Created by boli on 2018/10/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUPendingNoticeVC.h"

@interface YUUPendingNoticeVC ()

@end

@implementation YUUPendingNoticeVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YUUMineMarket" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"挂单交易须知";
    
    UIImage *image;
    switch (_level) {
        case UserLevelNovice:
            self.title = @"新手挂单交易须知";
            image = [UIImage imageNamed:@"pending0.jpg"];
        break;
        case UserLevelAdvanced:
            self.title = @"进阶挂单交易须知";
            image = [UIImage imageNamed:@"pending1.jpg"];
        break;
        case UserLevelMaster:
            self.title = @"高手挂单交易须知";
            image = [UIImage imageNamed:@"pending2.jpg"];
        break;
        case UserLevelInternational:
            self.title = @"国际挂单交易须知";
            image = [UIImage imageNamed:@"pending2.jpg"];
        break;
        
        default:
        break;
    }
    
    CGRect frame = self.view.bounds;
    frame.origin.y += self.navigationController.navigationBar.frame.size.height + 20;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, image.size.height/(image.size.width/scrollView.frame.size.width));
    [scrollView addSubview:imageView];
    [scrollView setContentSize:CGSizeMake(0, imageView.frame.size.height)];
    [self.view addSubview:scrollView];
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
