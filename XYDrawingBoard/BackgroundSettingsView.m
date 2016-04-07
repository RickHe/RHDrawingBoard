//
//  BackgroundSettingsView.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "BackgroundSettingsView.h"
#import "RGBColorPicker.h"
#import "UIView+UIViewController.h"

@interface BackgroundSettingsView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_pickerController;
}

@property (weak, nonatomic) IBOutlet RGBColorPicker *colorPicker;

@end

@implementation BackgroundSettingsView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:232.0 / 255 green:232.0 / 255 blue:232.0 / 255 alpha:1];
    __weak __typeof__(self)weakSelf = self;
    self.colorPicker.colorChangedBlock = ^(UIColor *color) {
        if (weakSelf.backgroundColorChangedBlock) {
            weakSelf.backgroundColorChangedBlock(color);
        }
    };
}

- (void)setBackgroundColor:(UIColor *)color {
    [self.colorPicker setCurrentColor:color];
    [super setBackgroundColor:color];
}

- (IBAction)pickImage:(id)sender {
    _pickerController = [UIImagePickerController new];
    _pickerController.delegate = self;
    [self.viewController presentViewController:_pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  照片获取完成
 *
 *  @param picker
 *  @param info
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    if (self.backgroundImageChangedBlock) {
        self.backgroundImageChangedBlock(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  取消获取照片
 *
 *  @param picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

