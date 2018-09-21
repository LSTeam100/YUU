//
//  YUUSellerInfo.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDView.h"
#import "YUUBorderTextField.h"
#import "HUDProtocol.h"
#import "YUUPendingMailboxModel.h"

@interface YUUSellerInfoView : HUDView

+ (instancetype)xibInstancetype;

@property (nonatomic, weak) id <HUDProtocol> delegate;

@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField0;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField1;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField2;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField3;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField4;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField5;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField6;


@property (strong, nonatomic) IBOutlet UIButton *btn0;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (nonatomic, strong) NSArray *textFields;

@property (nonatomic, strong) YUUPendingMailboxModel *model;

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet UILabel *label;



@end

@interface sellerInfoBtn : UIButton

@end


