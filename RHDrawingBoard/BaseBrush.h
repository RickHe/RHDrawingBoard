//
//  BaseBrush.h
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BaseBrush : NSObject

- (void)drawInContext:(CGContextRef )context;
- (BOOL)supportedContinuousDrawing;

@property (nonatomic, assign)CGPoint beginPoint;
@property (nonatomic, assign)CGPoint endPoint;
@property (nonatomic, assign)CGPoint lastPoint;
@property (nonatomic, assign)CGFloat strokeWidth;

@end
