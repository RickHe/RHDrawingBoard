//
//  RGBColorPicker.m
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "RGBColorPicker.h"

@interface RGBColorPicker ()
{
    NSMutableArray *_sliders;
    NSMutableArray *_labels;
}
@end

@implementation RGBColorPicker

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _sliders = [NSMutableArray array];
        _labels = [NSMutableArray array];
        [self p_initial];
    }
    return self;
}

- (void)p_initial {
    self.backgroundColor = [UIColor clearColor];
    NSArray *trackColors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    
    CGFloat sliderHeight = 31.0;
    CGFloat labelWidth = 45;
    CGFloat yHeight = self.bounds.size.height / 3;
    for (int i = 0; i < 3; i++) {
        UISlider *slider = [[UISlider alloc] init];
        NSLog(@"%f", [UIScreen mainScreen].bounds.size.width);
        slider.frame = CGRectMake(0, i * yHeight, [UIScreen mainScreen].bounds.size.width - labelWidth - 5, sliderHeight);
        slider.minimumValue = 0;
        slider.maximumValue = 255;
        slider.value = 0;
        slider.tag = i;
        slider.minimumTrackTintColor = trackColors[i];
        [slider addTarget:self action:@selector(colorChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        [_sliders addObject:slider];
        
        UILabel *valueLabel = [[UILabel alloc] init];
        valueLabel.frame = CGRectMake(CGRectGetMaxX(slider.frame) + 5, slider.frame.origin.y, labelWidth, sliderHeight);
        valueLabel.text  = @"0";
        [self addSubview:valueLabel];
        [_labels addObject:valueLabel];
    }
}

- (void)colorChanged:(UISlider *)slider {
    UIColor *color = [UIColor colorWithRed:((UISlider *)_sliders[0]).value / 255.0 green:((UISlider *)_sliders[1]).value / 255.0  blue:((UISlider *)_sliders[2]).value / 255.0  alpha:1];
    UILabel *valueLabel = _labels[slider.tag];
    valueLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    if (self.colorChangedBlock) {
        self.colorChangedBlock(color);
    }
}

- (void)setCurrentColor:(UIColor *)color {
    CGFloat red = 0, green = 0, blue = 0;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    NSArray *colors = @[@(red), @(green), @(blue)];
    for (int i = 0; i < _sliders.count; i++) {
        UISlider *slider = _sliders[i];
        slider.value = [colors[i] floatValue];
        UILabel *valueLabel = _labels[i];
        valueLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    }
}

@end
