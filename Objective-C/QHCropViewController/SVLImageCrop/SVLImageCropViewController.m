//
//  SVLImageCropViewController.m
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "SVLImageCropViewController.h"

#import "Masonry.h"
#import "SVLImageCropToolbar.h"

static const CGFloat kSVLImageViewControllerToolbarHeight = kSVLImageCropToolbarTopHeight + kSVLImageCropToolbarBottomHeight;

@interface SVLImageCropViewController ()

@property (nonatomic, strong) SVLImageCropToolbar *imgToolbar;
@property (nonatomic, assign) BOOL imgFirstTime;

@end

@implementation SVLImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SVLImageCropToolbar *imgToolbar = [[SVLImageCropToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:imgToolbar];
    _imgToolbar = imgToolbar;
    
    __weak typeof(self) weakSelf = self;
    self.imgToolbar.cancelBtnTapped = ^{ [weakSelf cancelBtnTappedAction]; };
    self.imgToolbar.doneBtnTapped   = ^{ [weakSelf doneBtnTappedAction]; };
    self.imgToolbar.clampBtnTapped = ^(QHCropViewControllerAspectRatioPreset aspectRatioPreset) {
        [weakSelf aspectRatioTappedAction:aspectRatioPreset];
    };
    
    // Layout the views initially
    UIView *cropView = self.cropView;
    // Masonry 与 presentAnimatedFromParentViewController，由于 self.cropView.angle 的惰性加载有异常，cropView.superview == nil 导致崩溃，所以这里添加处理
    [self.view addSubview:cropView];
    CGRect frame = [self frameForCropViewWithVerticalLayout:YES];
    [cropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(cropView.superview);
        make.height.mas_equalTo(frame.size.height);
    }];
    [imgToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cropView.mas_bottom);
        make.left.right.equalTo(imgToolbar.superview);
        make.height.mas_equalTo(kSVLImageViewControllerToolbarHeight);
    }];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.imgFirstTime == NO) {
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset4x3 animated:NO];
        self.aspectRatioLockEnabled = YES;
        self.imgFirstTime = YES;
    }
}

#pragma mark - Priavte

- (CGRect)frameForToolbarWithVerticalLayout:(BOOL)verticalLayout {
    CGRect frame = [super frameForToolbarWithVerticalLayout:verticalLayout];
    CGFloat diffHieght = kSVLImageViewControllerToolbarHeight - kQHCropViewControllerToolbarHeight;
    frame.origin.y -= diffHieght;
    frame.size.height += diffHieght;
    return frame;
}

- (CGRect)frameForCropViewWithVerticalLayout:(BOOL)verticalLayout {
    CGRect frame = [super frameForCropViewWithVerticalLayout:verticalLayout];
    CGFloat diffHieght = kSVLImageViewControllerToolbarHeight - kQHCropViewControllerToolbarHeight;
    frame.size.height -= diffHieght;
    return frame;
}

#pragma mark - Action

- (void)cancelBtnTappedAction {
    [self cancelButtonTapped];
}

- (void)doneBtnTappedAction {
    [self doneButtonTapped];
}

- (void)aspectRatioTappedAction:(TOCropViewControllerAspectRatioPreset)aspectRatioPreset {
    [self setAspectRatioPreset:aspectRatioPreset animated:YES];
}

@end
