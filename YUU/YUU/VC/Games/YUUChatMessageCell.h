//
//  YUUChatMessageCell.h
//  YUU
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUUChatMessageCell : UITableViewCell
    @property(nonatomic,weak)IBOutlet UIImageView *headImageView;
    @property(nonatomic,weak)IBOutlet UILabel *nameLabel;
    @property(nonatomic,weak)IBOutlet UILabel *contentLabel;
-(void)setContentText:(NSString *)text;
@end
