//
//  PaintingBrushSettingView.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "PaintingBrushSettingView.h"
#import "RGBColorPicker.h"

@interface PaintingBrushSettingView ()
@property (weak, nonatomic) IBOutlet UISlider *strokeWidthSlider;
@property (weak, nonatomic) IBOutlet UIView *strokeColorPreview;
@property (weak, nonatomic) IBOutlet RGBColorPicker *colorPicker;

@end

@implementation PaintingBrushSettingView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.strokeColorPreview.backgroundColor = backgroundColor;
    [self.colorPicker setCurrentColor:backgroundColor];
    super.backgroundColor = backgroundColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.strokeColorPreview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.strokeColorPreview.layer.borderWidth = 1;
    __weak __typeof__(self)weakSelf = self;
    self.colorPicker.colorChangedBlock = ^(UIColor *color) {
        weakSelf.strokeColorPreview.backgroundColor = color;
        if (weakSelf.strokeColorChangedBlock) {
            weakSelf.strokeColorChangedBlock(color);
        }
    };
    [self.strokeWidthSlider addTarget:self action:@selector(strokeWidthChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)strokeWidthChanged:(UISlider *)slider {
    if (self.strokeWidthChangedBlock) {
        self.strokeWidthChangedBlock(slider.value);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
