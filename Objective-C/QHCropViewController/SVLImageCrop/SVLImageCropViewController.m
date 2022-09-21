//
//  SVLImageCropViewController.m
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "SVLImageCropViewController.h"

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
    
    _imgToolbar = [[SVLImageCropToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_imgToolbar];
    
    __weak typeof(self) weakSelf = self;
    self.imgToolbar.cancelBtnTapped = ^{ [weakSelf cancelBtnTappedAction]; };
    self.imgToolbar.doneBtnTapped   = ^{ [weakSelf doneBtnTappedAction]; };
    self.imgToolbar.clampBtnTapped = ^(QHCropViewControllerAspectRatioPreset aspectRatioPreset) {
        [weakSelf aspectRatioTappedAction:aspectRatioPreset];
    };
    
    // Layout the views initially
    self.cropView.frame = [self frameForCropViewWithVerticalLayout:YES];
    self.imgToolbar.frame = [self frameForToolbarWithVerticalLayout:YES];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.imgFirstTime == NO) {
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset4x3 animated:NO];
        self.aspectRatioLockEnabled = YES;
        self.imgFirstTime = YES;
    }
    
    [UIView performWithoutAnimation:^{
        self.imgToolbar.frame = [self frameForToolbarWithVerticalLayout:YES];
        [self.imgToolbar setNeedsLayout];
    }];
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
