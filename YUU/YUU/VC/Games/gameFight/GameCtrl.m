//
//  GameCtrl.m
//  YUU
//
//  Created by apple on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameCtrl.h"
#import "YUUCanDefenseRequest.h"
#import "AlertController.h"


@interface GameCtrl ()
@end

@implementation GameCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self conigureCardType];

    self.waitView.backgroundColor = colorWithHexString(@"283040", 1.0);
    self.waitView.layer.cornerRadius = 10;
    UIPanGestureRecognizer *panGestureRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.bowman setUserInteractionEnabled:YES];
    [self.bowman addGestureRecognizer:panGestureRecognizer1];
    
    UIPanGestureRecognizer *panGestureRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];

    [self.cavalry setUserInteractionEnabled:YES];
    [self.cavalry addGestureRecognizer:panGestureRecognizer2];
    
    UIPanGestureRecognizer *panGestureRecognizer3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];

    [self.infantry setUserInteractionEnabled:YES];
    [self.infantry addGestureRecognizer:panGestureRecognizer3];
    
    
    NSMutableArray *uidArr = [self addUidImageView:@"0238889"];

    [self createUidImageView:uidArr];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)conigureCardType{
    self.leftCardType = cardTypeUnkonw;
    self.midCardType = cardTypeUnkonw;
    self.rightCardType = cardTypeUnkonw;
    
}
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        
        if ([self limitBorder:view Translation:translation]) {
            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        if ([self findCardPosion:view DefaultView:self.leftDefaultView]) {
            [self updateCardPosion:view DefaultView:self.leftDefaultView];
            self.leftCardType = view.tag;
        }
        else if ([self findCardPosion:view DefaultView:self.middleDefaultView]){
            [self updateCardPosion:view DefaultView:self.middleDefaultView];
            self.midCardType = view.tag;
        }
        else if ([self findCardPosion:view DefaultView:self.rightDefaultView]){
            [self updateCardPosion:view DefaultView:self.rightDefaultView];
            self.rightCardType = view.tag;
        }
        else{
            switch (view.tag) {
                case 0:
                    self.leftCardType = cardTypeUnkonw;
                    break;
                case 1:
                    self.midCardType = cardTypeUnkonw;
                    break;
                case 2:
                    self.rightCardType = cardTypeUnkonw;
                default:
                    break;
            }
            DLOG(@"不在放置区");
        }
    }
}

- (BOOL)limitBorder:(UIView *)cardView Translation:(CGPoint)translation{
    float maxWidth = [UIScreen mainScreen].bounds.size.width;
    float maxHeight = [UIScreen mainScreen].bounds.size.height;
    if (CGRectGetMaxX(cardView.frame) + translation.x > maxWidth) {
        return false;
    }
    else if (CGRectGetMaxY(cardView.frame) + translation.y > maxHeight){
        return false;
    }
    else if (CGRectGetMinX(cardView.frame) + translation.x < 0){
        return false;
    }
    else if (CGRectGetMinY(cardView.frame) + translation.y < 0){
        return false;
    }
    else{
        return YES;
    }
    
}


-(void)updateCardPosion:(UIView *)gestureView DefaultView:(UIView *)defaultView{
    if (gestureView.tag == cardTypeBowman) {
        self.bowman.center = defaultView.center;
    }
    else if (gestureView.tag == cardTypeCavalry){
        self.cavalry.center = defaultView.center;
    }
    else if (gestureView.tag == cardTypeinfantry){
        self.infantry.center = defaultView.center;
    }
}

-(NSMutableArray *)addUidImageView:(NSString *)uidStr{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [uidStr length]; i++) {
        NSString *c = [uidStr substringWithRange:NSMakeRange(i, 1)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"num_%@",c]];
        [arr addObject:image];
    }
    return arr;
}
-(void)createUidImageView:(NSMutableArray *)uidArr{
//    15 24
    CGSize size = CGSizeMake(15, 24);
    for (int i = 1; i <= uidArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 24)];
        imgView.image = uidArr[i-1];
        CGPoint p = CGPointMake(CGRectGetMaxX(self.maohaoImageView.frame) + (((size.width / 2)+6) * i), self.maohaoImageView.center.y);
        
        imgView.center = p;
        [self.view addSubview:imgView];
        
    }
    
}

-(BOOL)findCardPosion:(UIView *)gestureView DefaultView:(UIView *)defaultView{
    CGPoint p = [gestureView convertPoint:gestureView.center toView:defaultView];
    if (CGRectContainsPoint(gestureView.frame, p)) {
        return YES;
    }
    else{
        return NO;
    }
}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)startFight:(id)sender{
    NSString *token = [YUUUserData shareInstance].token;
    if (self.leftCardType > cardTypeUnkonw && self.midCardType > cardTypeUnkonw && self.rightCardType > cardTypeUnkonw) {
        
        [AlertController alertTitle:@"您确认如此排兵布阵了吗？" message:nil determine:@"确定" cancel:@"取消" determineHandler:^{
            [self setBusyIndicatorVisible:true];
            WeakSelf
            YUUCanDefenseRequest *attack = [[YUUCanDefenseRequest alloc] initWithCanDefense:token FirstCard:[NSString stringWithFormat:@"%ld",(long)self.leftCardType] secondCard:[NSString stringWithFormat:@"%ld",(long)self.midCardType] ThirdCard:[NSString stringWithFormat:@"%ld",(long)self.rightCardType] YuuNum:[NSString stringWithFormat:@"%f",self.yuuNum] SuccessCallback:^(YUUBaseRequest *request) {
                [weakSelf setBusyIndicatorVisible:false];
            } failureCallback:^(YUUBaseRequest *request) {
                [weakSelf setBusyIndicatorVisible:false];
                [weakSelf handleResponseError:weakSelf request:request needToken:YES];
            }];
           
            [attack start];
        } cancelHandler:^{
            
        }];
        
        
    }
    else{
        [HUD showHUDTitle:@"请保证每张卡放在准备区" durationTime:2];
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
