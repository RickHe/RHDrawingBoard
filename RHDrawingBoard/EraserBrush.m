
//
//  EraserBrush.m
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "EraserBrush.h"

@interface EraserBrush ()

@end

@implementation EraserBrush

- (void)drawInContext:(CGContextRef)context {
    CGContextSetBlendMode(context, kCGBlendModeClear);
    [super drawInContext:context];
}

@end
