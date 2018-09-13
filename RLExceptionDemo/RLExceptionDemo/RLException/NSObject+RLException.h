//
//  NSObject+RLException.h
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import <Foundation/Foundation.h>

void RLSwizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector);

void RLSwizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector);

void RLSwizzleClassMethodNames(NSArray *classNames, SEL originSelector, SEL swizzleSelector);

void RLSwizzleInstanceMethodNames(NSArray *classNames, SEL originSelector, SEL swizzleSelector);

@interface NSObject (RLException)

+ (void)rl_swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)rl_swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

@end
