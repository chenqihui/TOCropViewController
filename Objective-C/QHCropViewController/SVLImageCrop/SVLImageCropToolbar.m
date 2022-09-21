//
//  SVLImageCropToolbar.m
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "SVLImageCropToolbar.h"

#import "Masonry.h"

static const CGFloat kSVLImageCropToolbarRationWidth = 48.f;

@interface SVLImageCropToolbar ()

@property (nonatomic, strong) UIView *topV;
@property (nonatomic, strong) UIView *bottomV;

@end

@implementation SVLImageCropToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setup];
    }
    
    return self;
}

#pragma mark - Priavte

- (void)p_setup {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *topV = [[UIView alloc] initWithFrame:CGRectZero];
    topV.backgroundColor = [UIColor clearColor];
    [self addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topV.superview);
        make.height.mas_equalTo(kSVLImageCropToolbarTopHeight);
    }];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat spaceX = (width - kSVLImageCropToolbarRationWidth * 2) / 3;
    _topV = topV;
    {
        {
            UIView *v = [UIView new];
            v.backgroundColor = [UIColor clearColor];
            [topV addSubview:v];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(v.superview).mas_offset(spaceX);
                make.width.height.mas_equalTo(kSVLImageCropToolbarRationWidth);
                make.centerY.equalTo(v.superview);
            }];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"3:4" forState:UIControlStateNormal];
            btn.tag = 34;
            [btn addTarget:self action:@selector(clampAction:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(btn.superview);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(40);
            }];
        }
        {
            UIView *v = [UIView new];
            v.backgroundColor = [UIColor clearColor];
            [topV addSubview:v];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(v.superview).mas_offset(-spaceX);
                make.width.height.mas_equalTo(kSVLImageCropToolbarRationWidth);
                make.centerY.equalTo(v.superview);
            }];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"16:9" forState:UIControlStateNormal];
            btn.tag = 169;
            [btn addTarget:self action:@selector(clampAction:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(btn.superview);
                make.width.mas_equalTo(kSVLImageCropToolbarRationWidth);
                make.height.mas_equalTo(27);
            }];
        }
    }
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectZero];
    bottomV.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(bottomV.superview);
        make.height.mas_equalTo(kSVLImageCropToolbarBottomHeight);
    }];
    _bottomV = bottomV;
    {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.tag = 748;
        [cancelBtn addTarget:self action:@selector(operAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomV addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cancelBtn.superview);
            make.width.mas_equalTo(58);
            make.height.mas_equalTo(27);
            make.left.equalTo(cancelBtn.superview).mas_offset(12);
        }];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        doneBtn.tag = 521;
        [doneBtn addTarget:self action:@selector(operAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomV addSubview:doneBtn];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(doneBtn.superview);
            make.width.mas_equalTo(58);
            make.height.mas_equalTo(27);
            make.right.equalTo(doneBtn.superview).mas_offset(-12);
        }];
    }
}

#pragma mark - Action

- (void)clampAction:(UIButton *)sender {
    if (self.clampBtnTapped) {
        self.clampBtnTapped(sender.tag == 169 ? TOCropViewControllerAspectRatioPreset4x3 : TOCropViewControllerAspectRatioPreset16x9);
    }
}

- (void)operAction:(UIButton *)sender {
    if (sender.tag == 748 && self.cancelBtnTapped) {
        self.cancelBtnTapped();
    }
    else if (sender.tag == 521 && self.doneBtnTapped) {
        self.doneBtnTapped();
    }
}

@end
