//
//  DBUndoManager.h
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DBUndoManager : NSObject

@property (nonatomic, assign) BOOL canUndo;
@property (nonatomic, assign) BOOL canRedo;

- (void)addImage:(UIImage *)image;
- (UIImage *)imageForUndo;
- (UIImage *)imageForRedo;

@end
