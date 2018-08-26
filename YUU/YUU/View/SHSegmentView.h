//
//  SHSegmentView.h
//  YUU
//
//  Created by boli on 2018/8/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentSelectedAtIndex)(NSInteger);

@interface SHSegmentView : UIView

@property (nonatomic, copy) SegmentSelectedAtIndex selectedBlock;

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *buttons;

- (void)setTitles:(NSArray *)titles segmentSelectedAtIndex:(SegmentSelectedAtIndex)selectBlock;

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index;

- (void)setSegmentTitles:(NSArray *)titles segmentSelectedAtIndex:(SegmentSelectedAtIndex)selectBlock;

@end
