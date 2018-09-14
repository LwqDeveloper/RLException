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
        //        NSArray *arrayClassTitles = @[@"__NSArray0", @"__NSArrayI", @"__NSSingleObjectArrayI", @"__NSPlaceholderArray"];
        
        /** array[3] -[__NSArrayI objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(@[@"__NSArrayI", @"__NSSingleObjectArrayI"], @selector(objectAtIndexedSubscript:), @selector(rl_array_objectAtIndexedSubscript:));
        
        /** [array objectAtIndex:3] -[__NSArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 2] */
        RLSwizzleInstanceMethodNames(@[@"__NSArrayI", @"__NSSingleObjectArrayI"], @selector(objectAtIndex:), @selector(rl_array_objectAtIndex:));
        
        /** [array addObject:@"3"] -[__NSArrayI addObject:]: unrecognized selector sent to instance 0x604000248550 */
        RLSwizzleInstanceMethodNames(@[@"__NSArrayI", @"__NSSingleObjectArrayI"], @selector(addObject:), @selector(rl_array_addObject:));
        
        /** -[__NSArrayI objectForKeyedSubscript:]: unrecognized selector sent to instance 0x60000044ada0 */
        /** -[__NSSingleObjectArrayI objectForKeyedSubscript:]: unrecognized selector sent to instance 0x60400001a310 */
        RLSwizzleInstanceMethodNames(@[@"__NSArrayI", @"__NSSingleObjectArrayI"], @selector(objectForKeyedSubscript:), @selector(rl_array_objectForKeyedSubscript:));
        
        /** -[__NSArrayI objectForKey:]: unrecognized selector sent to instance 0x604000220000 */
        /** -[__NSSingleObjectArrayI objectForKey:]: unrecognized selector sent to instance 0x60000000ffe0 */
        RLSwizzleInstanceMethodNames(@[@"__NSArrayI", @"__NSSingleObjectArrayI"], @selector(objectForKey:), @selector(rl_array_objectForKey:));
        
    });
}

- (id)rl_array_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_array_objectAtIndex:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (id)rl_array_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self rl_array_objectAtIndexedSubscript:index];
    }
    NSLog(@"RLException %@:%@ out index", NSStringFromClass([self class]), @(index));
    return nil;
}

- (void)rl_array_addObject:(id)object
{
    NSLog(@"RLException %@:can't add object:%@", NSStringFromClass([self class]), object);
    return ;
}

- (id)rl_array_objectForKeyedSubscript:(id)key
{
    NSLog(@"RLException %@:can't objectForKeyedSubscript:%@", NSStringFromClass([self class]), key);
    return nil;
}

- (id)rl_array_objectForKey:(id)key
{
    NSLog(@"RLException %@:can't objectForKey:%@", NSStringFromClass([self class]), key);
    return nil;
}

@end
