//
//  DashLineBrush.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "DashLineBrush.h"

@interface DashLineBrush () 

@end

@implementation DashLineBrush

// 虚线
- (void)drawInContext:(CGContextRef)context {
    CGFloat lengths[] = {self.strokeWidth * 3, self.strokeWidth * 3};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, self.beginPoint.x, self.beginPoint.y);
    CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
}

@end
