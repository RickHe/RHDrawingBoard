//
//  LineBrush.m
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "LineBrush.h"

@interface LineBrush () 

@end

@implementation LineBrush

- (void)drawInContext:(CGContextRef)context {
    CGContextMoveToPoint(context, self.beginPoint.x, self.beginPoint.y);
    CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
}

@end
