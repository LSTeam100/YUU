//
//  GameCtrl.m
//  YUU
//
//  Created by apple on 2018/11/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GameCtrl.h"
typedef NS_ENUM(NSInteger,cardType){
    cardTypeBowman = 0,
    cardTypeCavalry = 1,
    cardTypeinfantry = 2,
};



@interface GameCtrl ()
@end

@implementation GameCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        }
        else if ([self findCardPosion:view DefaultView:self.middleDefaultView]){
            [self updateCardPosion:view DefaultView:self.middleDefaultView];
        }
        else if ([self findCardPosion:view DefaultView:self.rightDefaultView]){
            [self updateCardPosion:view DefaultView:self.rightDefaultView];
        }
        else{
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
