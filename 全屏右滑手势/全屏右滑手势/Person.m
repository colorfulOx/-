//
//  Person.m
//  全屏右滑手势
//
//  Created by lirenqiang on 16/7/7.
//  Copyright © 2016年 lirenqiang. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+ (void)load {
    
//    Method originalMethod = class_getInstanceMethod([self class], @selector(eat));
//    Method swizzledMethod = class_getInstanceMethod([self class], @selector(run));
        
//    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    Method method = class_getInstanceMethod([self class], @selector(sleep));
    IMP imp = method_getImplementation(method);
    const char * types = method_getTypeEncoding(method);
    class_replaceMethod([self class], @selector(eat), imp, types);
}

- (void)eat {
    NSLog(@"eat");
}

- (void)run {
    NSLog(@"run");
}

- (void)sleep {
    NSLog(@"sleep");
}

@end
