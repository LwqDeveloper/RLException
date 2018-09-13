//
//  NSArray+RLException.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSArray+RLException.h"
#import "NSObject+RLException.h"

@implementation NSArray (RLException)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
            __NSPlaceholderArray [NSArray alloc] alloc后未初始化的数组
            __NSArray0 [[NSArray alloc] init] 初始化的空数组
            __NSArrayI 初始化后有值的  不可变数组
            __NSArrayM 初始化后有值的  可变数组
            __NSSingleObjectArrayI 初始化后只有一个值的  不可变数组
            __NSFrozenArrayM 可变数组 copy后
         */
        NSArray *arrayClassTitles = @[@"__NSArray0", @"__NSArrayI", @"__NSSingleObjectArrayI", @"__NSPlaceholderArray"];
        
        /** [array objectAtIndex:3] -[__NSArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectAtIndex:), @selector(rl_objectAtIndex:));

        /** array[3] -[__NSArrayI objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectAtIndexedSubscript:), @selector(rl_objectAtIndexedSubscript:));

        /** [array addObject:nil] -[__NSSingleObjectArrayI addObject:]: unrecognized selector sent to instance 0x604000013850 */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(addObject:), @selector(rl_addObject:));
    });
}

- (id)rl_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_objectAtIndex:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (id)rl_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_objectAtIndexedSubscript:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (void)rl_addObject:(id)object
{
    if (object) {
        [self rl_addObject:object];
        return ;
    }
    NSLog(@"RLException %@:add object is nill", NSStringFromClass([self class]));
}


@end
