//
//  BackgroundSettingsView.h
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackgroundImageChangedBlock)(UIImage *image);
typedef void(^BackgroundColorChangedBlock)(UIColor *color);

@interface BackgroundSettingsView : UIView

@property (nonatomic, copy) BackgroundColorChangedBlock backgroundColorChangedBlock;
@property (nonatomic, copy) BackgroundImageChangedBlock backgroundImageChangedBlock;

- (void)setBackgroundColor:(UIColor *)color;

@end
