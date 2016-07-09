//
//  MSLObjcEx.m
//  全屏右滑手势
//
//  Created by lirenqiang on 16/7/7.
//  Copyright © 2016年 lirenqiang. All rights reserved.
//

#import "MSLObjcEx.h"
#import <objc/runtime.h>

@implementation MSLObjcEx

+ (void)msl_logMethods:(Class)className {
    unsigned int outCount;
    Method * methods = class_copyMethodList(className, &outCount);
    
    for (NSInteger i = 0; i < outCount; i++) {
        Method method = methods[i];
        SEL methodN = method_getName(method);
        NSLog(@"%@", NSStringFromSelector(methodN));
    }
    
}

+ (void)msl_logIvars:(Class)className; {
        unsigned int outCount;
        Ivar * ivars = class_copyIvarList(className, &outCount);
        for (NSInteger i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            const char * ivarN = ivar_getName(ivar);
            NSLog(@"%s", ivarN);
        }
}

+ (void)msl_logProperties:(Class)className {
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList(className, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char * propertyN = property_getName(property);
        NSLog(@"%s", propertyN);
    }
}





@end
