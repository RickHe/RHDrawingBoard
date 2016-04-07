
//
//  EllipseBrush.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "EllipseBrush.h"

@interface EllipseBrush () 

@end

@implementation EllipseBrush

- (void)drawInContext:(CGContextRef)context {
        CGRect rect = CGRectMake(self.beginPoint.x, self.beginPoint.y, self.endPoint.x - self.beginPoint.x, self.endPoint.y - self.beginPoint.y);
    CGContextAddEllipseInRect(context, rect);
}

@end
