//
//  ViewController.m
//  SVLImageCropViewControllerDemo
//
//  Created by qihuichen on 2022/9/21.
//  Copyright © 2022 Tim Oliver. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>

#import "SVLImageCropViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, QHCropViewControllerDelegate>

@property (nonatomic, strong) UIImage *image;           // The image we'll be cropping
@property (nonatomic, strong) UIImageView *imageView;   // The image view to present the cropped image

@property (nonatomic, assign) QHCropViewCroppingStyle croppingStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"V"];
    iv.userInteractionEnabled = YES;
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iv];
    self.imageView = iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iv.superview);
        make.left.equalTo(iv.superview).mas_offset(30);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    [self p_layoutImageView];
    
    if (@available(iOS 11.0, *)) {
        self.imageView.accessibilityIgnoresInvertColors = YES;
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageAction)];
    [self.imageView addGestureRecognizer:tapRecognizer];
    
    UILabel *titleL = [UILabel new];
    titleL.font = [UIFont systemFontOfSize:25];
    titleL.textColor = [UIColor blackColor];
    titleL.text = @"此处是标题";
    titleL.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iv);
        make.left.equalTo(iv.mas_right).mas_offset(20);
        make.right.equalTo(iv.superview).mas_offset(-30);
        make.height.equalTo(iv);
    }];
}

#pragma mark - Private

- (void)p_layoutImageView {
    if (self.imageView.image == nil)
        return;
    
    CGFloat w = 60;
    CGFloat h = 80;
    if (self.imageView.image.size.width > self.imageView.image.size.height) {
        w = 90;
        h = 51;
    }
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
    }];
}

- (void)p_showCropViewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Crop Image", @"")
                                             style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               self.croppingStyle = QHCropViewCroppingStyleDefault;
                                               
                                               UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
                                               standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                               standardPicker.allowsEditing = NO;
                                               standardPicker.delegate = self;
                                               [self presentViewController:standardPicker animated:YES completion:nil];
                                           }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera", @"")
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
        self.croppingStyle = QHCropViewCroppingStyleDefault;
        
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraPicker.allowsEditing = NO;
        cameraPicker.delegate = self;
        [self presentViewController:cameraPicker animated:YES completion:nil];
                                         }];
    
    [alertController addAction:defaultAction];
    [alertController addAction:cameraAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
    popPresenter.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    SVLImageCropViewController *vc = [[SVLImageCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    vc.delegate = self;

    self.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - QHCropViewControllerDelegate

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController {
    self.imageView.image = image;
    self.image = self.imageView.image;
    [self p_layoutImageView];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (cropViewController.croppingStyle != TOCropViewCroppingStyleCircular) {
        self.imageView.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self
                                                   withCroppedImage:image
                                                             toView:self.imageView
                                                            toFrame:CGRectZero
                                                              setup:^{ [self p_layoutImageView]; }
                                                         completion:
         ^{
            self.imageView.hidden = NO;
        }];
    }
    else {
        self.imageView.hidden = NO;
        [cropViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Action

- (void)didTapImageAction {
    [self p_showCropViewController];
}

@end
