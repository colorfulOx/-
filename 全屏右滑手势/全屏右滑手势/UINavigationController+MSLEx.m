//
//  UINavigationController+MSLEx.m
//  全屏右滑手势
//
//  Created by lirenqiang on 16/7/8.
//  Copyright © 2016年 lirenqiang. All rights reserved.
//

#import "UINavigationController+MSLEx.h"
#import <objc/runtime.h>


@interface MSLFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController * navigationController;

@end

@implementation MSLFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {

    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end


@implementation UINavigationController (MSLEx)

+ (void)load {
    
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(msl_pushViewController:animated:));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
}

- (void)msl_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //首先对当前的View进行判断是否有我们自己要添加的手势,如果没有,进入if体内.
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.msl_popGestureRecognizer]) {
        
        //在这里,我们添加自己的手势.
        //interactivePopGestureRecognizer: 该属性表示的是:负责popnavigation栈中最顶层的控制器的手势识别器.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.msl_popGestureRecognizer];
        
        NSArray * targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        
        self.msl_popGestureRecognizer.delegate = [self msl_fullScreenPopGestureRecognizerDelegate];
        [self.msl_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self msl_pushViewController:viewController animated:YES];
    }
    
}

- (MSLFullScreenPopGestureRecognizerDelegate *)msl_fullScreenPopGestureRecognizerDelegate {
    
    MSLFullScreenPopGestureRecognizerDelegate * delegate = objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        
        delegate = [[MSLFullScreenPopGestureRecognizerDelegate alloc] init];
        
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return delegate;
}

- (UIPanGestureRecognizer *)msl_popGestureRecognizer {
    
    UIPanGestureRecognizer * popGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!popGestureRecognizer) {
        
        popGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        
        popGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, popGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return popGestureRecognizer;
}

@end
