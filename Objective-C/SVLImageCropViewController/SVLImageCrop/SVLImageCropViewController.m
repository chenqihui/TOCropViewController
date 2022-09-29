//
//  SVLImageCropViewController.m
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "SVLImageCropViewController.h"

#import <Masonry/Masonry.h>

#import "SVLImageCropToolbar.h"

static const CGFloat kSVLImageViewControllerToolbarHeight = kSVLImageCropToolbarTopHeight + kSVLImageCropToolbarBottomHeight;

@interface SVLImageCropViewController ()

@property (nonatomic, strong) SVLImageCropToolbar *imgToolbar;
@property (nonatomic, assign) BOOL imgFirstTime;

@end

@implementation SVLImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aspectRatioLockEnabled = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    SVLImageCropToolbar *imgToolbar = [[SVLImageCropToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:imgToolbar];
    
    __weak typeof(self) weakSelf = self;
    imgToolbar.cancelBtnTapped = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf cancelBtnTappedAction];
    };
    imgToolbar.doneBtnTapped   = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf doneBtnTappedAction];
    };
    imgToolbar.clampBtnTapped = ^(SVLImageCropViewControllerAspectRatioPreset preset) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf aspectRatioTappedAction:preset];
    };
    
    UIView *cropView = self.cropView;
    // Masonry 与 presentAnimatedFromParentViewController，由于 self.cropView.angle 的惰性加载有异常，cropView.superview == nil 导致崩溃，所以这里添加处理
    if (cropView.superview == nil) { [self.view addSubview:cropView]; }
    CGRect frame = [self frameForCropViewWithVerticalLayout:YES];
    cropView.frame = frame;
    [imgToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cropView.mas_bottom);
        make.left.right.equalTo(imgToolbar.superview);
        make.height.mas_equalTo(kSVLImageViewControllerToolbarHeight);
    }];
    
    imgToolbar.currentPreset = SVLImageCropViewControllerAspectRatioPreset3x4;
    _imgToolbar = imgToolbar;
    [self p_defaultAspectRatioPreset];
}

#pragma mark - Priavte

- (CGRect)frameForToolbarWithVerticalLayout:(BOOL)verticalLayout {
    CGRect frame = [super frameForToolbarWithVerticalLayout:verticalLayout];
    CGFloat diffHieght = kSVLImageViewControllerToolbarHeight - kQHCropViewControllerToolbarHeight;
    frame.origin.y -= diffHieght;
    frame.size.height = kSVLImageViewControllerToolbarHeight;
    return frame;
}

- (CGRect)frameForCropViewWithVerticalLayout:(BOOL)verticalLayout {
    CGRect frame = [super frameForCropViewWithVerticalLayout:verticalLayout];
    CGFloat diffHieght = kSVLImageViewControllerToolbarHeight - kQHCropViewControllerToolbarHeight;
    frame.size.height -= diffHieght;
    return frame;
}

- (void)p_defaultAspectRatioPreset {
    self.customAspectRatio = CGSizeMake(3, 4);
}

#pragma mark - Action

- (void)cancelBtnTappedAction {
    [self cancelButtonTapped];
}

- (void)doneBtnTappedAction {
    [self doneButtonTapped];
}

- (void)aspectRatioTappedAction:(SVLImageCropViewControllerAspectRatioPreset)preset {
    [self.cropView resetLayoutToDefaultAnimated:YES];
    if (preset == SVLImageCropViewControllerAspectRatioPreset16x9) {
        [self setAspectRatioPreset:QHCropViewControllerAspectRatioPreset16x9 animated:YES];
    }
    else {
        [self p_defaultAspectRatioPreset];
    }
}

@end
