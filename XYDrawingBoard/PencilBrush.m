//
//  PencilBrush.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "PencilBrush.h"

@interface PencilBrush()

@end

@implementation PencilBrush

- (void)drawInContext:(CGContextRef)context {
    CGPoint lastPoint = self.lastPoint;
    if (lastPoint.x != 0 || lastPoint.y != 0) {
        CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
    } else {
        CGContextMoveToPoint(context, self.beginPoint.x, self.beginPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
    }
}

- (BOOL)supportedContinuousDrawing {
    return YES;
}

@end
