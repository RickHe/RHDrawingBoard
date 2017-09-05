
//
//  DBUndoManager.m
//  RHDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "DBUndoManager.h"
#import "DBImageFault.h"

@interface DBUndoManager ()
{
    NSMutableArray *_images;
    NSInteger _index;
    NSMutableString *_basePath;
}
@end

@implementation DBUndoManager

static NSInteger INVALID_INDEX = -1;
static NSInteger cahcesLength = 3;

- (instancetype)init {
    if ((self = [super init])) {
        _basePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) firstObject] mutableCopy];
        _images = [NSMutableArray array];
        _index = INVALID_INDEX;
    }
    return self;
}

- (void)addImage:(UIImage *)image {
    // 当往这个 Manager 中增加图片的时候，先把指针后面的图片全部清掉，
    // 这与我们之前在 drawingImage 方法中对 redoImages 的处理是一样的
    if (_index < _images.count - 1) {
        for (NSInteger i = _index + 1; i < _images.count; i++) {
            [_images removeObjectAtIndex:i];
        }
    }
    [_images addObject:image];
    // 更新 index 的指向
    _index = _images.count - 1;
    [self p_setNeedsCache];
}

- (UIImage *)imageForUndo {
    if (self.canUndo) {
        --_index;
        if (!self.canUndo) {
            return nil;
        } else {
            [self p_setNeedsCache];
            return _images[_index];
        }
    } else {
        return nil;
    }
}

- (UIImage *)imageForRedo {
    if (self.canRedo) {
        [self p_setNeedsCache];
        return _images[++_index];
    } else {
        return nil;
    }
}

#pragma mark - Getter
- (BOOL)canRedo {
    return (_index + 1) < _images.count;
}

- (BOOL)canUndo {
    return _index != INVALID_INDEX;
}

#pragma mark - Private
- (void)p_setFaultImage:(UIImage *)image forIndex:(NSInteger)index {
    if (![image isKindOfClass:[DBImageFault class]]) {
        NSString *imagePath = [_basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"\%li", index]];
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:imagePath atomically:false];
        _images[index] = [DBImageFault new];
    }
}

- (void)p_setRealImage:(UIImage *)image forIndex:(NSInteger)index {
    if ([image isKindOfClass:[DBImageFault class]]) {
        NSString *imagePath = [_basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"\%li", index]];
        _images[index] = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
}

- (void)p_setNeedsCache {
    if (_images.count >= cahcesLength) {
        NSInteger location = MAX(0, _index - cahcesLength);
        NSInteger length = MIN(_images.count - 1, _index + cahcesLength);
        for (NSInteger i = location; i <= length; i++) {
            @autoreleasepool {
                UIImage *image = _images[i];
                if (i > _index - cahcesLength && i < _index + cahcesLength) {
                    // 如果在缓存区域中，则从文件加载
                    [self p_setRealImage:image forIndex:i];
                } else {
                    // 如果不在缓存区域中，则置成 Fault 对象
                    [self p_setFaultImage:image forIndex:i];
                }
            }
        }
    }
}

@end
