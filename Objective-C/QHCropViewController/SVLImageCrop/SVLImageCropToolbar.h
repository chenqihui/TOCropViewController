//
//  SVLImageCropToolbar.h
//  TOCropViewController
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TOCropViewConstants.h"

static const CGFloat kSVLImageCropToolbarTopHeight = 85.5f;
static const CGFloat kSVLImageCropToolbarBottomHeight = 50.5f;

NS_ASSUME_NONNULL_BEGIN

@interface SVLImageCropToolbar : UIView

@property (nullable, nonatomic, copy) void (^cancelBtnTapped)(void);
@property (nullable, nonatomic, copy) void (^doneBtnTapped)(void);
@property (nullable, nonatomic, copy) void (^clampBtnTapped)(TOCropViewControllerAspectRatioPreset aspectRatioPreset);

@end

NS_ASSUME_NONNULL_END
