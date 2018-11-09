//
//  LastRankVC.m
//  YUU
//
//  Created by boli on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LastRankVC.h"
#import "RankCell.h"

@interface LastRankVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *currentWeekBtn;
@property (strong, nonatomic) IBOutlet UIView *upView;
@property (strong, nonatomic) IBOutlet UILabel *upContentLabel;
@property (strong, nonatomic) IBOutlet UIView *middleView;

@end

@implementation LastRankVC

+ (instancetype)storyboardInstanceType {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"game" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentWeekBtnAction:(id)sender {
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell"];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  74;
}

@end
