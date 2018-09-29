//
//  SHSegmentView.m
//  YUU
//
//  Created by boli on 2018/8/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SHSegmentView.h"
#import "Header.h"


@implementation SHSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - buttons -
- (void)setTitles:(NSArray *)titles segmentSelectedAtIndex:(SegmentSelectedAtIndex)selectBlock {
    _selectedBlock = selectBlock;
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"segment_%ld",(long)titles.count]];
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    
    if (titles.count == 2) {
        UIButton *left = [[UIButton alloc] init];
        [self addSubview:left];
        [self setButtonStyle:left];
        [left setBackgroundImage:[UIImage imageNamed:@"btn_left_selected"] forState:UIControlStateNormal];
        [left setBackgroundImage:nil forState:UIControlStateSelected];
        [left setTitle:titles[0] forState:UIControlStateNormal];
        left.tag = 0;
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(1);
            make.height.mas_equalTo(self).mas_offset(-2);
            make.width.mas_equalTo(self).multipliedBy(0.5).mas_offset(-2);
        }];
        
        UIButton *right = [[UIButton alloc] init];
        [self addSubview:right];
        [self setButtonStyle:right];
        [right setBackgroundImage:[UIImage imageNamed:@"btn_right_selected"] forState:UIControlStateNormal];
        [right setBackgroundImage:nil forState:UIControlStateSelected];
        [right setTitle:titles[1] forState:UIControlStateNormal];
        right.tag = 1;
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-1);
            make.height.mas_equalTo(self).mas_offset(-2);
            make.width.mas_equalTo(self).multipliedBy(0.5).mas_offset(-2);
        }];
        
        _buttons = @[left, right];
    } else {
        
    }
    
}

- (void)setButtonStyle:(UIButton *)btn {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:YUUYellow forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(didSelectAtIndex:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didSelectAtIndex:(UIButton *)btn {
    if (_selectedBlock) {
        _selectedBlock(btn.tag);
    }
}

#pragma mark - segment labels -

- (void)setSegmentTitles:(NSArray *)titles segmentSelectedAtIndex:(SegmentSelectedAtIndex)selectBlock {
    _selectedBlock = selectBlock;
    if (titles.count == 2) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"segment_2"];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self);
        }];

        UIImageView *left = [[UIImageView alloc] init];
        left.image = [UIImage imageNamed:@"btn_left_selected"];
        [self addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(1);
            make.height.mas_equalTo(self).mas_offset(-2);
            make.width.mas_equalTo(self).multipliedBy(0.5).mas_offset(-2);
        }];

        UIImageView *right = [[UIImageView alloc] init];
        right.image = [UIImage imageNamed:@"btn_right_selected"];
        [self addSubview:right];
        right.hidden = YES;
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-1);
            make.height.mas_equalTo(self).mas_offset(-2);
            make.width.mas_equalTo(self).multipliedBy(0.5).mas_offset(-2);
        }];

        _imageViews = @[left, right];

        UILabel *leftLable = [[UILabel alloc] init];
        [self addSubview:leftLable];
        [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];
        leftLable.backgroundColor = [UIColor clearColor];
        leftLable.textColor = [UIColor whiteColor];
        leftLable.font = [UIFont systemFontOfSize:14];
        leftLable.text = titles[0];
        leftLable.textAlignment = NSTextAlignmentCenter;

        leftLable.userInteractionEnabled = YES;
        leftLable.tag = 0;
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentSelected:)];
        [leftLable addGestureRecognizer:leftTap];

        UILabel *rightLable = [[UILabel alloc] init];
        [self addSubview:rightLable];
        [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];
        rightLable.backgroundColor = [UIColor clearColor];
        rightLable.textColor = YUUYellow;
        rightLable.font = [UIFont systemFontOfSize:14];
        rightLable.text = titles[1];
        rightLable.textAlignment = NSTextAlignmentCenter;

        rightLable.userInteractionEnabled = YES;
        rightLable.tag = 1;
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentSelected:)];
        [rightLable addGestureRecognizer:rightTap];

        _labels = @[leftLable, rightLable];

    } else if (titles.count == 3) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"segment_3"];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self);
        }];

        UIImageView *left = [[UIImageView alloc] init];
        left.image = [UIImage imageNamed:@"btn_left_selected"];
        [self addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).mas_offset(-1);
            make.left.mas_equalTo(self).mas_offset(1);
            make.height.mas_equalTo(self).mas_offset(-4);
            make.width.mas_equalTo(self).multipliedBy(0.33).mas_offset(0);
        }];

        UIImageView *middle = [[UIImageView alloc] init];
        middle.image = [UIImage imageNamed:@"btn_middle_selected"];
        [self addSubview:middle];
        middle.hidden = YES;
        [middle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).mas_offset(-1);
            make.left.mas_equalTo(left.mas_right).mas_offset(1);
            make.height.mas_equalTo(self).mas_offset(-4);
            make.width.mas_equalTo(self).multipliedBy(0.33).mas_offset(-2);
        }];

        UIImageView *right = [[UIImageView alloc] init];
        right.image = [UIImage imageNamed:@"btn_right_selected"];
        [self addSubview:right];
        right.hidden = YES;
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).mas_offset(-1);
            make.right.mas_equalTo(self).mas_offset(-1);
            make.height.mas_equalTo(self).mas_offset(-4);
            make.width.mas_equalTo(self).multipliedBy(0.33).mas_offset(0);
        }];

        _imageViews = @[left, middle, right];

        UILabel *leftLable = [[UILabel alloc] init];
        [self addSubview:leftLable];
        [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.33);
        }];
        leftLable.backgroundColor = [UIColor clearColor];
        leftLable.textColor = [UIColor whiteColor];
        leftLable.font = [UIFont systemFontOfSize:14];
        leftLable.text = titles[0];
        leftLable.textAlignment = NSTextAlignmentCenter;

        leftLable.userInteractionEnabled = YES;
        leftLable.tag = 0;
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentSelected:)];
        [leftLable addGestureRecognizer:leftTap];

        UILabel *middleLable = [[UILabel alloc] init];
        [self addSubview:middleLable];
        [middleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(leftLable.mas_right);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.33);
        }];
        middleLable.backgroundColor = [UIColor clearColor];
        middleLable.textColor = YUUYellow;
        middleLable.font = [UIFont systemFontOfSize:14];
        middleLable.text = titles[1];
        middleLable.textAlignment = NSTextAlignmentCenter;

        middleLable.userInteractionEnabled = YES;
        middleLable.tag = 1;
        UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentSelected:)];
        [middleLable addGestureRecognizer:middleTap];

        UILabel *rightLable = [[UILabel alloc] init];
        [self addSubview:rightLable];
        [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(middleLable.mas_right);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.33);
        }];
        rightLable.backgroundColor = [UIColor clearColor];
        rightLable.textColor = YUUYellow;
        rightLable.font = [UIFont systemFontOfSize:14];
        rightLable.text = titles[2];
        rightLable.textAlignment = NSTextAlignmentCenter;

        rightLable.userInteractionEnabled = YES;
        rightLable.tag = 2;
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentSelected:)];
        [rightLable addGestureRecognizer:rightTap];

        _labels = @[leftLable, middleLable, rightLable];
    }
}

- (void)segmentSelected:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag;
    for (int i = 0; i < _imageViews.count; i++) {
        UIImageView *imageView = _imageViews[i];
        if (tag == i) {
            imageView.hidden = NO;
        } else {
            imageView.hidden = YES;
        }
    }

    for (int i = 0; i < _labels.count; i++) {
        UILabel *label = _labels[i];
        if (tag == i) {
            label.textColor = [UIColor whiteColor];
        } else {
            label.textColor = YUUYellow;
        }
    }

    if (_selectedBlock) {
        _selectedBlock(tag);
    }
}

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index {
    if (index < 0 || index >= _labels.count) {
        return;
    }
    UILabel *label = _labels[index];
    label.text = title;
}

@end
