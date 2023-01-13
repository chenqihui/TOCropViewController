//
//  QHCropNamespace.h
//  QHPhotoEditDemo
//
//  Created by qihuichen on 2022/9/20.
//

/*
 QHCropNamespace
 使用：
 参考：SVLImageCropViewControllerDemo -> ViewController
 记得 pod install
 * [chenqihui/TOCropViewController at sohu](https://github.com/chenqihui/TOCropViewController/tree/sohu)
 
 基础：
 * [TimOliver/TOCropViewController: A view controller for iOS that allows users to crop portions of UIImage objects](https://github.com/TimOliver/TOCropViewController)
 
 说明：
 使用 TOCropViewController 第三方库
 使用如下宏替换
 最重要的是尊重开源作者，保留其前缀，又避免冲突，还可以最小化升级，一举三得
 
 更新注意：
 当由于功能界面不同，会修改 TOCropViewController 等小部分内容
 */

#ifndef QHCropNamespace_h
#define QHCropNamespace_h

// TOCropViewController
#define kTOCropViewControllerToolbarHeight kQHCropViewControllerToolbarHeight
#define TOCropViewController QHCropViewController
#define TOCropViewControllerDelegate QHCropViewControllerDelegate

// CropRotate
#define TOCropRotate QHCropRotate

// TOCropViewConstants
#define TOCropViewConstants QHCropViewConstants
#define TOCropViewCroppingStyle                         QHCropViewCroppingStyle
#define TOCropViewCroppingStyleDefault                  QHCropViewCroppingStyleDefault
#define TOCropViewCroppingStyleCircular                 QHCropViewCroppingStyleCircular
#define TOCropViewControllerAspectRatioPreset           QHCropViewControllerAspectRatioPreset
#define TOCropViewControllerAspectRatioPresetOriginal   QHCropViewControllerAspectRatioPresetOriginal
#define TOCropViewControllerAspectRatioPresetSquare     QHCropViewControllerAspectRatioPresetSquare
#define TOCropViewControllerAspectRatioPreset3x2        QHCropViewControllerAspectRatioPreset3x2
#define TOCropViewControllerAspectRatioPreset5x3        QHCropViewControllerAspectRatioPreset5x3
#define TOCropViewControllerAspectRatioPreset4x3        QHCropViewControllerAspectRatioPreset4x3
#define TOCropViewControllerAspectRatioPreset5x4        QHCropViewControllerAspectRatioPreset5x4
#define TOCropViewControllerAspectRatioPreset7x5        QHCropViewControllerAspectRatioPreset7x5
#define TOCropViewControllerAspectRatioPreset16x9       QHCropViewControllerAspectRatioPreset16x9
#define TOCropViewControllerAspectRatioPresetCustom     QHCropViewControllerAspectRatioPresetCustom

#define TOCropViewControllerToolbarPosition         QHCropViewControllerToolbarPosition
#define TOCropViewControllerToolbarPositionBottom   QHCropViewControllerToolbarPositionBottom
#define TOCropViewControllerToolbarPositionTop      QHCropViewControllerToolbarPositionTop

#define TO_CROP_VIEW_RESOURCE_BUNDLE_FOR_OBJECT QH_CROP_VIEW_RESOURCE_BUNDLE_FOR_OBJECT

// TOActivityCroppedImageProvider
#define TOActivityCroppedImageProvider QHActivityCroppedImageProvider

// TOCropViewControllerTransitioning
#define TOCropViewControllerTransitioning QHCropViewControllerTransitioning

// TOCroppedImageAttributes
#define TOCroppedImageAttributes QHCroppedImageAttributes

// TOCropView
#define TOCropView QHCropView
#define TOCropViewDelegate QHCropViewDelegate
#define kTOCropViewPadding kQHCropViewPadding
#define kTOCropTimerDuration kQHCropTimerDuration
#define kTOCropViewMinimumBoxSize kQHCropViewMinimumBoxSize

#define TOCropViewOverlayEdge               QHCropViewOverlayEdge
#define TOCropViewOverlayEdgeNone           QHCropViewOverlayEdgeNone
#define TOCropViewOverlayEdgeTopLeft        QHCropViewOverlayEdgeTopLeft
#define TOCropViewOverlayEdgeTop            QHCropViewOverlayEdgeTop
#define TOCropViewOverlayEdgeTopRight       QHCropViewOverlayEdgeTopRight
#define TOCropViewOverlayEdgeRight          QHCropViewOverlayEdgeRight
#define TOCropViewOverlayEdgeBottomRight    QHCropViewOverlayEdgeBottomRight
#define TOCropViewOverlayEdgeBottom         QHCropViewOverlayEdgeBottom
#define TOCropViewOverlayEdgeBottomLeft     QHCropViewOverlayEdgeBottomLeft
#define TOCropViewOverlayEdgeLeft           QHCropViewOverlayEdgeLeft

// TOCropOverlayView
#define TOCropOverlayView QHCropOverlayView
#define kTOCropOverLayerCornerWidth kQHCropOverLayerCornerWidth

// TOCropToolbar
#define TOCropToolbar QHCropToolbar

// TOCropScrollView
#define TOCropScrollView QHCropScrollView


#endif /* QHCropNamespace_h */
