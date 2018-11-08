//
//  YUUChatMessageCell.m
//  YUU
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import "YUUChatMessageCell.h"

@implementation YUUChatMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor = YUUYellow;
//    self.contentLabel.textColor = YUUYellow;
//    self.contentLabel.layer.borderWidth = 0.5;
//    self.contentLabel.layer.borderColor = YUUYellow.CGColor;
//    
//    self.backgroundColor = [UIColor clearColor];
//    
//    CALayer *mask = [CALayer layer];
//    mask.opacity = 1;
//    mask.backgroundColor = YUUYellow.CGColor;
//    mask.cornerRadius = 10;
////    mask.masksToBounds = YES;
//    mask.frame = CGRectMake(0, 0, 100, 40);
//    self.contentLabel.layer.mask = mask;
//    [self.contentLabel sizeToFit];
//    
//    DLOG(@"w=%f",self.contentLabel.frame.size.width);
//    DLOG(@"h=%f",self.contentLabel.frame.size.height);

    // Initialization code
}
-(void)setContentText:(NSString *)text{
    self.contentLabel.text = text;
    self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.contentLabel.numberOfLines = 0;

    CGSize size = [self.contentLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - self.contentLabel.frame.origin.x - 10, 1000)];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x,self.contentLabel.frame.origin.y, size.width, size.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
