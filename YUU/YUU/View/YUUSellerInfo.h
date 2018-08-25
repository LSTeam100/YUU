//
//  YUUSellerInfo.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUUSellerInfo : UIView

+ (instancetype)xibInstancetype;

@property (strong, nonatomic) IBOutlet UILabel *label0;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;
@property (strong, nonatomic) IBOutlet UILabel *label6;

@property (strong, nonatomic) IBOutlet UIButton *btn0;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (nonatomic, strong) NSArray *labels;

@end

@interface sellerInfoBtn : UIButton

@end

@interface sellerInfoBg : UIView

@end
