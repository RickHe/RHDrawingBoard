//
//  BaseBrush.m
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "BaseBrush.h"

@interface BaseBrush ()

@end

@implementation BaseBrush

- (BOOL)supportedContinuousDrawing {
    return NO;
}

- (void)drawInContext:(CGContextRef)context {
    NSAssert(false, @"must implements in subclass.");
}


@end
