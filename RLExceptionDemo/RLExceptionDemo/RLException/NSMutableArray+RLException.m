//
//  NSMutableArray+RLException.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSMutableArray+RLException.h"
#import "NSObject+RLException.h"

@implementation NSMutableArray (RLException)

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
        NSArray *arrayClassTitles = @[@"__NSArrayM"];
        
        /** array[3] -[__NSArrayI objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectAtIndexedSubscript:), @selector(rl_mulArray_objectAtIndexedSubscript:));
        
        /** [array objectAtIndex:3] -[__NSArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectAtIndex:), @selector(rl_mulArray_objectAtIndex:));
        
        /** -[__NSArrayM removeObjectsInRange:]: range {3, 1} extends beyond bounds [0 .. 1] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(removeObjectsInRange:), @selector(rl_mulArray_removeObjectsInRange:));
        
        /** [array addObject:nil] -[__NSArrayM insertObject:atIndex:]: object cannot be nil */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(addObject:), @selector(rl_mulArray_addObject:));
        
        /** *** -[__NSArrayM insertObject:atIndex:]: object cannot be nil */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(insertObject:atIndex:), @selector(rl_mulArray_insertObject:atIndex:));
        
        /** -[__NSArrayM replaceObjectAtIndex:withObject:]: index 3 beyond bounds [0 .. 1] */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(replaceObjectAtIndex:withObject:), @selector(rl_mulArray_replaceObjectAtIndex:withObject:));
        
        /** -[__NSArrayM objectForKeyedSubscript:]: unrecognized selector sent to instance 0x60000044ada0 */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectForKeyedSubscript:), @selector(rl_mulArray_objectForKeyedSubscript:));
        
        /** -[__NSArrayM objectForKey:]: unrecognized selector sent to instance 0x604000220000 */
        RLSwizzleInstanceMethodNames(arrayClassTitles, @selector(objectForKey:), @selector(rl_mulArray_objectForKey:));
    });
}

- (id)rl_mulArray_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_mulArray_objectAtIndex:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (id)rl_mulArray_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_mulArray_objectAtIndexedSubscript:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (void)rl_mulArray_addObject:(id)object
{
    if (object) {
        [self rl_mulArray_addObject:object];
        return ;
    }
    NSLog(@"RLException %@:add object is nill", NSStringFromClass([self class]));
}

- (void)rl_mulArray_removeObjectsInRange:(NSRange)range
{
    if (range.location <= self.count -1 &&
        range.location +range.length <= self.count) {
        [self rl_mulArray_removeObjectsInRange:range];
        return ;
    }
    NSLog(@"RLException %@:RemoveObjectsInRange {%@, %@} extens beyoud bounds [0 .. %@]", NSStringFromClass([self class]),@(range.location), @(range.length), @(self.count -1));
}

- (void)rl_mulArray_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) {
        NSLog(@"RLException %@:insert object is nill, index:%@", NSStringFromClass([self class]), @(index));
        return ;
    }
    if (index > self.count) {
        NSLog(@"RLException %@:insert index %@ beyound bounds [0 .. %@]", NSStringFromClass([self class]),@(index), @(self.count -1));
        return ;
    }
    [self rl_mulArray_insertObject:anObject atIndex:index];
}

- (void)rl_mulArray_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject) {
        NSLog(@"RLException %@:replace object is nill", NSStringFromClass([self class]));
        return ;
    }
    if (index > self.count) {
        NSLog(@"RLException %@:replace index %@ beyound bounds [0 .. %@]", NSStringFromClass([self class]),@(index), @(self.count -1));
        return ;
    }
    [self rl_mulArray_replaceObjectAtIndex:index withObject:anObject];
}

- (id)rl_mulArray_objectForKeyedSubscript:(id)key
{
    NSLog(@"RLException %@:can't objectForKeyedSubscript:%@", NSStringFromClass([self class]), key);
    return nil;
}

- (id)rl_mulArray_objectForKey:(id)key
{
    NSLog(@"RLException %@:can't objectForKey:%@", NSStringFromClass([self class]), key);
    return nil;
}

@end
