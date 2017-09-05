//
//  UIView+UIViewController.m
//  WXMovie
//
//  Created by imac on 15/9/2.
//  Copyright (c) 2015年 朱思明. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    while (![responder isKindOfClass:[UIViewController class]] && responder != nil) {
        responder = responder.nextResponder;
    }
    return (UIViewController *)responder;
}

@end
