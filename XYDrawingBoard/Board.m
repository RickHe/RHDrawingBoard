//
//  Board.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "Board.h"
#import "DBUndoManager.h"

@interface Board ()
{
    UIImage *_realImage;
    DBUndoManager *_boardUndoManager;  // 缓存或Undo控制器
    kDrawingState _drawingState;
}
@end

@implementation Board

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _boardUndoManager = [DBUndoManager new];
        _strokeColor = [UIColor blackColor];
        _strokeWidth = 1.0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _boardUndoManager = [DBUndoManager new];
        _strokeColor = [UIColor blackColor];
        _strokeWidth = 1.0;
    }
    return self;
}

- (void)undo {
    if (self.canUndo) {
        self.image = [_boardUndoManager imageForUndo];
        _realImage = self.image;
    } else {
        return;
    }
}

- (void)redo {
    if (self.canRedo) {
        self.image = [_boardUndoManager imageForRedo];
        _realImage = self.image;
    } else {
        return;
    }
}

- (UIImage *)takeImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.backgroundColor setFill];
    UIRectFill(self.bounds);
    [self.image drawInRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Getter
- (BOOL)canRedo {
    return _boardUndoManager.canRedo;
}

- (BOOL)canUndo {
    return _boardUndoManager.canUndo;
}

#pragma mark - Private
- (void)p_drawingImage {
    BaseBrush *brush = self.brush;
    if (brush) {
        // hook
        if (self.drawingStateChangedBlock) {
            self.drawingStateChangedBlock(_drawingState);
        }
        
        UIGraphicsBeginImageContext(self.bounds.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor clearColor] setFill];
        UIRectFill(self.bounds);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, self.strokeWidth);
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        
        if (_realImage){
            [_realImage drawInRect:self.bounds];
        }
        
        brush.strokeWidth = self.strokeWidth;
        [brush drawInContext:context];
        CGContextStrokePath(context);
        
        UIImage *previewImage = UIGraphicsGetImageFromCurrentImageContext();
        if (_drawingState == kDrawingStateEnd || [brush supportedContinuousDrawing]) {
            _realImage = previewImage;
        }
        
        UIGraphicsEndImageContext();
        
        // 用 Ended 事件代替原先的 Began 事件
        if (_drawingState == kDrawingStateEnd) {
            [_boardUndoManager addImage:self.image];
        }
        
        self.image = previewImage;
        
        brush.lastPoint = brush.endPoint;
    }
}

#pragma mark - TouchMethod
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseBrush *brush = self.brush;
    if (brush) {
        brush.lastPoint = CGPointMake(0, 0);
        brush.beginPoint = [[touches anyObject] locationInView:self];
        brush.endPoint = brush.beginPoint;
        _drawingState = kDrawingStateBegin;
        [self p_drawingImage];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseBrush *brush = self.brush;
    if (brush) {
        brush.endPoint = [[touches anyObject] locationInView:self];
        _drawingState = kDrawingStateMoved;
        [self p_drawingImage];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseBrush *brush = self.brush;
    if (brush) {
        brush.endPoint = CGPointMake(0, 0);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseBrush *brush = self.brush;
    if (brush) {
        brush.endPoint = [[touches anyObject] locationInView:self];
        _drawingState = kDrawingStateEnd;
        [self p_drawingImage];
    }
}

@end
