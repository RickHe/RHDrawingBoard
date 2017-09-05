//
//  Board.h
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBrush.h"

typedef enum : NSUInteger {
    kDrawingStateBegin,
    kDrawingStateMoved,
    kDrawingStateEnd,
} kDrawingState;

typedef void(^DrawingStateChangedBlock)(kDrawingState state);

@interface Board : UIImageView

@property (nonatomic, strong) BaseBrush *brush;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, copy) DrawingStateChangedBlock drawingStateChangedBlock;
@property (nonatomic, readonly, assign) BOOL canUndo;
@property (nonatomic, readonly, assign) BOOL canRedo;

- (void)undo;
- (void)redo;
- (UIImage *)takeImage;

@end
