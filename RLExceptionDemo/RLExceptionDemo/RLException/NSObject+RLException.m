//
//  NSObject+RLException.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSObject+RLException.h"

#import <objc/runtime.h>

void RLSwizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector)
{
    if (!cls) {
        return;
    }
    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzleSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            class_replaceMethod(metacls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

void RLSwizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector)
{
    if (!cls) {
        return;
    }
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzleSelector);
    
    /* add selector if not exist, implement append with method */
    if (class_addMethod(cls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(cls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(cls,
                            swizzleSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

void RLSwizzleClassMethodNames(NSArray *classNames, SEL originSelector, SEL swizzleSelector)
{
    if (classNames.count == 0) {
        return;
    }
    for (NSString *className in classNames) {
        RLSwizzleClassMethod(NSClassFromString(className), originSelector, swizzleSelector);
    }
}

void RLSwizzleInstanceMethodNames(NSArray *classNames, SEL originSelector, SEL swizzleSelector)
{
    if (classNames.count == 0) {
        return;
    }
    for (NSString *className in classNames) {
        RLSwizzleInstanceMethod(NSClassFromString(className), originSelector, swizzleSelector);
    }
}

@implementation NSObject (RLException)

+ (void)rl_swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector
{
    RLSwizzleClassMethod(self.class, originSelector, swizzleSelector);
}

- (void)rl_swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector
{
    RLSwizzleInstanceMethod(self.class, originSelector, swizzleSelector);
}
@end
