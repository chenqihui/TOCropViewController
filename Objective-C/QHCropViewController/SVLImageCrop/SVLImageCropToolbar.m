//
//  SVLImageCropToolbar.m
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "SVLImageCropToolbar.h"

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

- (void)layoutSubviews {
    _topV.frame = CGRectMake(0, 0, self.frame.size.width, kSVLImageCropToolbarTopHeight);
    _bottomV.frame = CGRectMake(0, kSVLImageCropToolbarTopHeight, self.frame.size.width, kSVLImageCropToolbarBottomHeight);
}

#pragma mark - Priavte

- (void)p_setup {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *topV = [[UIView alloc] initWithFrame:CGRectZero];
    _topV = topV;
    {
        UIButton *btn34 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn34.tag = 34;
        [btn34 addTarget:self action:@selector(clampAction:) forControlEvents:UIControlEventTouchUpInside];
        [topV addSubview:btn34];
        
        UIButton *btn169 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn169.tag = 169;
        [btn169 addTarget:self action:@selector(clampAction:) forControlEvents:UIControlEventTouchUpInside];
        [topV addSubview:btn169];
    }
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomV = bottomV;
    {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.tag = 748;
        [cancelBtn addTarget:self action:@selector(operAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomV addSubview:cancelBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.tag = 521;
        [doneBtn addTarget:self action:@selector(operAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomV addSubview:doneBtn];
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
