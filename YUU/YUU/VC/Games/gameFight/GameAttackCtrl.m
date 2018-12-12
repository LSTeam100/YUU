//
//  GameAttackCtrl.m
//  YUU
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameAttackCtrl.h"
#import "YUUStartAttackRequest.h"
#import "YUUUserData.h"
#import "HUD.h"
#import "WarbackRequest.h"
#import "YUUAttackResponseModel.h"

@interface GameAttackCtrl ()

@property (nonatomic, strong) YUUAttackResponseModel *responseModel;

@end

@implementation GameAttackCtrl

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
    self.awardLabel.textColor = [UIColor whiteColor];
    self.awardLabelTitle.textColor = colorWithHexString(@"ED6621", 1.0);
    
    
}
-(void)conigureCardType{
    self.leftCardType = cardTypeUnkonw;
    self.midCardType = cardTypeUnkonw;
    self.rightCardType = cardTypeUnkonw;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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

-(IBAction)back:(id)sender{
    [HUD showHUD];
    WarbackRequest *request = [[WarbackRequest alloc] initBattlenum:self.model.battlenum success:^(YUUBaseRequest *request) {
        [HUD showRequest:request];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(YUUBaseRequest *request) {
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
    
//    [self.navigationController popViewControllerAnimated:YES];
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

-(IBAction)startFight:(id)sender{
    NSString *token = [YUUUserData shareInstance].token;
    if (self.leftCardType > cardTypeUnkonw && self.midCardType > cardTypeUnkonw && self.rightCardType > cardTypeUnkonw) {
        [self setBusyIndicatorVisible:true];
        WeakSelf
        YUUStartAttackRequest *attack = [[YUUStartAttackRequest alloc]initWithStartattack:token FirstCard:[NSString stringWithFormat:@"%ld",self.leftCardType] secondCard:[NSString stringWithFormat:@"%ld",self.midCardType] ThirdCard:[NSString stringWithFormat:@"%ld",self.rightCardType] Battlenum:self.model.battlenum SuccessCallback:^(YUUBaseRequest *request) {
            [weakSelf setBusyIndicatorVisible:false];
            NSDictionary *dict = request.getResponse.responseObject;
            weakSelf.responseModel = [YUUAttackResponseModel mj_objectWithKeyValues:[dict objectForKey:@"data"]];
            [weakSelf showResult:weakSelf.responseModel];
        } failureCallback:^(YUUBaseRequest *request) {
            [weakSelf setBusyIndicatorVisible:false];
            [weakSelf handleResponseError:weakSelf request:request needToken:YES];
        }];
        [attack start];
    }
    else{
        [HUD showHUDTitle:@"请保证每张卡放在准备区" durationTime:2];
    }
    
//    _responseModel = [[YUUAttackResponseModel alloc] init];
//    _responseModel.firstbout = 2;
//    _responseModel.secondbout = 2;
//    _responseModel.thirdbout = 2;
//    [self showResult:_responseModel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showResult:(YUUAttackResponseModel *)model {
    _imageView0.tag = 0;
    _imageView1.tag = 1;
    _imageView2.tag = 2;
    
    [self performSelector:@selector(rotationImageView:) withObject:_imageView0 afterDelay:0];
    [self performSelector:@selector(rotationImageView:) withObject:_imageView1 afterDelay:0.4];
    [self performSelector:@selector(rotationImageView:) withObject:_imageView2 afterDelay:0.4*2];
}


- (void)rotationImageView:(UIImageView *)imageView {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    // 旋转角度， 其中的value表示图像旋转的最终位置
    keyAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI/2), 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           nil];
    keyAnimation.cumulative = NO;
    keyAnimation.duration = 0.5;
    keyAnimation.repeatCount = 1;
    keyAnimation.removedOnCompletion = NO;
//    keyAnimation.delegate = self;
    [imageView.layer addAnimation:keyAnimation forKey:@"transform"];
    [self changeIamgeInImageView:imageView];
}

- (void)changeIamgeInImageView:(UIImageView *)imageView {
    if (imageView.tag == 0) {
        if (self.leftCardType == cardTypeBowman) {
            if (_responseModel.firstbout == 0 || _responseModel.firstbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.firstbout == 2) {
                imageView.image = [UIImage imageNamed:@"bowman"];
            } else {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            }
        } else if (self.leftCardType == cardTypeCavalry) {
            if (_responseModel.firstbout == 0 || _responseModel.firstbout == 1) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else if (_responseModel.firstbout == 2) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        } else {
            if (_responseModel.firstbout == 0 || _responseModel.firstbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.firstbout == 2) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        }
    } else if (imageView.tag == 1) {
        if (self.midCardType == cardTypeBowman) {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"bowman"];
            } else {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            }
        } else if (self.midCardType == cardTypeCavalry) {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        } else {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        }
    } else {
        if (self.rightCardType == cardTypeBowman) {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"bowman"];
            } else {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            }
        } else if (self.rightCardType == cardTypeCavalry) {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        } else {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
            }
        }
    }
}



@end
