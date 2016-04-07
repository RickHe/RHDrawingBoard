//
//  PaintingBrushSettingView.h
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/6.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StrokeWidthChangedBlock)(CGFloat strokeWidth);
typedef void(^StrokeColorChangedBlock)(UIColor *strokeColor);

@interface PaintingBrushSettingView : UIView

@property (nonatomic, copy) StrokeWidthChangedBlock strokeWidthChangedBlock;
@property (nonatomic, copy) StrokeColorChangedBlock strokeColorChangedBlock;

@end
