//
//  UINavigationController+MSLEx.h
//  全屏右滑手势
//
//  Created by lirenqiang on 16/7/8.
//  Copyright © 2016年 lirenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MSLEx)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer * msl_popGestureRecognizer;

@end
