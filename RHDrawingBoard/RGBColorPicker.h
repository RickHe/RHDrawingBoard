//
//  RGBColorPicker.h
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ColorChangedBlock)(UIColor *color);

@interface RGBColorPicker : UIView

@property (nonatomic, copy)ColorChangedBlock colorChangedBlock;

- (void)setCurrentColor:(UIColor *)color;

@end
