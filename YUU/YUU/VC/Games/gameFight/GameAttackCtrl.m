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

#define animationDuration 1.5

@interface GameAttackCtrl ()

@property (nonatomic, strong) YUUAttackResponseModel *responseModel;

@property (nonatomic, strong) UIImageView *attactImageView0;
@property (nonatomic, strong) UIImageView *attactImageView1;
@property (nonatomic, strong) UIImageView *attactImageView2;
    
@property (nonatomic, assign) BOOL isGameOver;

@end

@implementation GameAttackCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self conigureCardType];

    self.waitView.backgroundColor = colorWithHexString(@"283040", 1.0);
    self.waitView.layer.cornerRadius = 10;
    
    // bowman
    UIPanGestureRecognizer *panGestureRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.bowman setUserInteractionEnabled:YES];
    [self.bowman addGestureRecognizer:panGestureRecognizer1];
    
    UIImageView *bowmanBack = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:bowmanBack belowSubview:self.bowman];
    [bowmanBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.left.mas_equalTo(self.bowman);
    }];
    bowmanBack.image = [UIImage imageNamed:@"bowman"];
    
    // cavalry
    UIPanGestureRecognizer *panGestureRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    
    [self.cavalry setUserInteractionEnabled:YES];
    [self.cavalry addGestureRecognizer:panGestureRecognizer2];
    
    UIImageView *cavalryBack = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:cavalryBack belowSubview:self.cavalry];
    [cavalryBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.left.mas_equalTo(self.cavalry);
    }];
    cavalryBack.image = [UIImage imageNamed:@"cavalry"];
    
    // infantry
    UIPanGestureRecognizer *panGestureRecognizer3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    
    [self.infantry setUserInteractionEnabled:YES];
    [self.infantry addGestureRecognizer:panGestureRecognizer3];
    
    UIImageView *infantryBack = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:infantryBack belowSubview:self.infantry];
    [infantryBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.left.mas_equalTo(self.infantry);
    }];
    infantryBack.image = [UIImage imageNamed:@"Infantry"];
    
    NSString *userid = [NSString stringWithFormat:@"%@",[YUUUserData shareInstance].userModel.memberid];
    
    NSMutableArray *uidArr = [self addUidImageView:userid];
    
    [self createUidImageView:uidArr];
    self.awardLabel.textColor = [UIColor whiteColor];
    self.awardLabelTitle.textColor = colorWithHexString(@"ED6621", 1.0);
    self.awardLabel.hidden = YES;
    
    _resultImage0.hidden = YES;
    _resultImage1.hidden = YES;
    _resultImage2.hidden = YES;
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
    if (_isGameOver) {
        return;
    }
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
            DLOG(@"不在放置区");
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
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
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];
    } failure:^(YUUBaseRequest *request) {
        [HUD hide];
        [self handleResponseError:self request:request needToken:YES];
    }];
    [request start];
}

-(void)updateCardPosion:(UIView *)gestureView DefaultView:(UIView *)defaultView {
    NSString *imageName = @"";
    if (gestureView.tag == cardTypeBowman) {
        imageName = @"bowman";
    } else if (gestureView.tag == cardTypeCavalry){
        imageName = @"cavalry";
    } else if (gestureView.tag == cardTypeinfantry){
        imageName = @"Infantry";
    }
    
    if (defaultView == self.leftDefaultView) {
        if (!_attactImageView0) {
            _attactImageView0 = [[UIImageView alloc] initWithFrame:defaultView.frame];
            [self.view addSubview:_attactImageView0];
        }
        _attactImageView0.image = [UIImage imageNamed:imageName];
    } else if (defaultView == self.middleDefaultView) {
        if (!_attactImageView1) {
            _attactImageView1 = [[UIImageView alloc] initWithFrame:defaultView.frame];
            [self.view addSubview:_attactImageView1];
        }
        _attactImageView1.image = [UIImage imageNamed:imageName];
    } else {
        if (!_attactImageView2) {
            _attactImageView2 = [[UIImageView alloc] initWithFrame:defaultView.frame];
            [self.view addSubview:_attactImageView2];
        }
        _attactImageView2.image = [UIImage imageNamed:imageName];
    }
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
    CGFloat lastImageMaxX = CGRectGetMaxX(self.maohaoImageView.frame);
    for (int i = 1; i <= uidArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 24)];
        imgView.image = uidArr[i-1];
        CGSize newsize = CGSizeMake(imgView.image.size.width * 0.9, imgView.image.size.height * 0.9);
        [imgView setFrame:CGRectMake(0, 0, newsize.width, newsize.height)];
        DLOG(@"imgeframe=%@",NSStringFromCGRect(imgView.frame));
        CGPoint p = CGPointMake(lastImageMaxX + (newsize.width / 2) +5, self.maohaoImageView.center.y);
        imgView.center = p;
        lastImageMaxX = CGRectGetMaxX(imgView.frame);
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
    if (_isGameOver) {
        [HUD showHUDTitle:@"游戏已结束，请重新开始" durationTime:1.6];
        return;
    }
    NSString *token = [YUUUserData shareInstance].token;
    if (self.leftCardType > cardTypeUnkonw && self.midCardType > cardTypeUnkonw && self.rightCardType > cardTypeUnkonw) {
        [self setBusyIndicatorVisible:true];
        WeakSelf
        YUUStartAttackRequest *attack = [[YUUStartAttackRequest alloc]initWithStartattack:token FirstCard:[NSString stringWithFormat:@"%ld",self.leftCardType] secondCard:[NSString stringWithFormat:@"%ld",self.midCardType] ThirdCard:[NSString stringWithFormat:@"%ld",self.rightCardType] Battlenum:self.model.battlenum SuccessCallback:^(YUUBaseRequest *request) {
            [weakSelf setBusyIndicatorVisible:false];
            NSDictionary *dict = request.getResponse.responseObject;
            weakSelf.responseModel = [YUUAttackResponseModel mj_objectWithKeyValues:[dict objectForKey:@"data"]];
            [weakSelf showResult:weakSelf.responseModel];
            dispatch_async(dispatch_get_main_queue(), ^{
             double yuu = weakSelf.responseModel.firstboutgetyuu+weakSelf.responseModel.secondboutgetyuu+weakSelf.responseModel.thirdboutgetyuu;
                self.awardLabel.text = [NSString stringWithFormat:@"%@",regYUUCoin([NSNumber numberWithDouble:yuu], 2)];
                self.awardLabel.hidden = NO;
                NSLog(@"%f",yuu);
            });
            weakSelf.isGameOver = YES;
        } failureCallback:^(YUUBaseRequest *request) {
            [weakSelf setBusyIndicatorVisible:false];
            [weakSelf handleResponseError:weakSelf request:request needToken:YES];
            weakSelf.isGameOver = YES;
        }];
        [attack start];
    } else {
        [HUD showHUDTitle:@"请保证每张卡放在准备区" durationTime:2];
    }
    
//    _responseModel = [[YUUAttackResponseModel alloc] init];
//    _responseModel.firstbout = 1;
//    _responseModel.secondbout = 2;
//    _responseModel.thirdbout = 4;
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
    
    [self performSelector:@selector(rotationImageView:) withObject:_imageView0 afterDelay:animationDuration*0];
    [self performSelector:@selector(rotationImageView:) withObject:_imageView1 afterDelay:animationDuration*2];
    [self performSelector:@selector(rotationImageView:) withObject:_imageView2 afterDelay:animationDuration*4];
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
    keyAnimation.duration = animationDuration;
    keyAnimation.repeatCount = 1;
    keyAnimation.removedOnCompletion = NO;
//    keyAnimation.delegate = self;
    [imageView.layer addAnimation:keyAnimation forKey:@"transform"];
//    [self changeIamgeInImageView:imageView];
    [self performSelector:@selector(changeIamgeInImageView:) withObject:imageView afterDelay:0.7];
}

- (void)changeIamgeInImageView:(UIImageView *)imageView {
    NSArray *imageNames = @[@"lose", @"nu", @"ping", @"win", @"bao"];
    if (imageView.tag == 0) {
        if (self.leftCardType == cardTypeBowman) {
            NSArray *images = @[@"cavalry", @"cavalry", @"bowman", @"Infantry", @"Infantry"];
            imageView.image = [UIImage imageNamed:images[_responseModel.firstbout]];
        } else if (self.leftCardType == cardTypeCavalry) {
            NSArray *images = @[@"Infantry", @"Infantry", @"cavalry", @"bowman", @"bowman"];
            imageView.image = [UIImage imageNamed:images[_responseModel.firstbout]];
        } else {
            NSArray *images = @[@"cavalry", @"cavalry", @"Infantry", @"bowman", @"bowman"];
            imageView.image = [UIImage imageNamed:images[_responseModel.firstbout]];
        }
        _resultImage0.image = [UIImage imageNamed:imageNames[_responseModel.firstbout]];
        _resultImage0.hidden = NO;
    } else if (imageView.tag == 1) {
        if (self.midCardType == cardTypeBowman) {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage1.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage1.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage1.image = [UIImage imageNamed:@"win"];
            }
        } else if (self.midCardType == cardTypeCavalry) {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage1.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage1.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage1.image = [UIImage imageNamed:@"win"];
            }
        } else {
            if (_responseModel.secondbout == 0 || _responseModel.secondbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage1.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.secondbout == 2) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage1.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage1.image = [UIImage imageNamed:@"win"];
            }
        }
        _resultImage1.image = [UIImage imageNamed:imageNames[_responseModel.secondbout]];
        _resultImage1.hidden = NO;
    } else {
        if (self.rightCardType == cardTypeBowman) {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage2.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage2.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage2.image = [UIImage imageNamed:@"win"];
            }
        } else if (self.rightCardType == cardTypeCavalry) {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage2.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage2.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage2.image = [UIImage imageNamed:@"win"];
            }
        } else {
            if (_responseModel.thirdbout == 0 || _responseModel.thirdbout == 1) {
                imageView.image = [UIImage imageNamed:@"cavalry"];
                _resultImage2.image = [UIImage imageNamed:@"lose"];
            } else if (_responseModel.thirdbout == 2) {
                imageView.image = [UIImage imageNamed:@"Infantry"];
                _resultImage2.image = [UIImage imageNamed:@"ping"];
            } else {
                imageView.image = [UIImage imageNamed:@"bowman"];
                _resultImage2.image = [UIImage imageNamed:@"win"];
            }
        }
        _resultImage2.image = [UIImage imageNamed:imageNames[_responseModel.thirdbout]];
        _resultImage2.hidden = NO;
    }
}



@end
