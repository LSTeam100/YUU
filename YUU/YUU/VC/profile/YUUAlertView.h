//
//  YUUAlertView.h
//  YUU
//
//  Created by apple on 2018/10/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUUAlertView : UIView
@property(nonatomic,weak)IBOutlet UIImageView *alertImageVIew;
-(void)showYUUAlert:(NSString *)imageName;
@end
