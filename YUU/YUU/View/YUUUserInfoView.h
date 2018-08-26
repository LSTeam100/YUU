//
//  YUUUserInfoView.h
//  YUU
//
//  Created by boli on 2018/8/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDView.h"
#import "YUUBorderTextField.h"
#import "HUDProtocol.h"
#import "YUUBorderButton.h"

@interface YUUUserInfoView : HUDView

+ (instancetype)xibInstancetype;

@property (nonatomic, weak) id <HUDProtocol> delegate;

@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField0;
@property (strong, nonatomic) IBOutlet YUUBorderTextField *textField1;

@property (strong, nonatomic) IBOutlet YUUBorderButton *btn0;
@property (strong, nonatomic) IBOutlet YUUBorderButton *btn1;

@end
