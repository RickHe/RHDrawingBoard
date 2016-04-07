
//
//  RectangleBrush.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "RectangleBrush.h"

@interface RectangleBrush () 

@end

@implementation RectangleBrush

- (void)drawInContext:(CGContextRef)context {
    CGRect rect = CGRectMake(self.beginPoint.x, self.beginPoint.y, self.endPoint.x - self.beginPoint.x, self.endPoint.y - self.beginPoint.y);
    CGContextAddRect(context, rect);
}

@end
