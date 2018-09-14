//
//  NSMutableDictionary+RLException.m
//  RLExceptionDemo
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/14.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSMutableDictionary+RLException.h"
#import "NSObject+RLException.h"

@implementation NSMutableDictionary (RLException)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /** -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil */
        RLSwizzleInstanceMethodNames(@[@"__NSDictionaryM"], @selector(setObject:forKeyedSubscript:), @selector(rl_mulDict_setObject:forKeyedSubscript:));
        
        /** -[__NSDictionaryM setObject:forKey:]: key cannot be nil */
        /** -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: 2) */
        RLSwizzleInstanceMethodNames(@[@"__NSDictionaryM"], @selector(setObject:forKey:), @selector(rl_mulDict_setObject:forKey:));
        
        /** -[__NSDictionaryM removeObjectForKey:]: key cannot be nil */
        RLSwizzleInstanceMethodNames(@[@"__NSDictionaryM"], @selector(removeObjectForKey:), @selector(rl_mulDict_removeObjectForKey:));
    });
}

- (void)rl_mulDict_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (key) {
        [self rl_mulDict_setObject:obj forKeyedSubscript:key];
        return ;
    }
    NSLog(@"RLException %@:key:%@ cannot be nil", NSStringFromClass([self class]), key);
}

- (void)rl_mulDict_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (aKey && anObject) {
        [self rl_mulDict_setObject:anObject forKey:aKey];
        return ;
    }
    NSLog(@"RLException %@:setObject:%@ forKey:%@ cannot be nil", NSStringFromClass([self class]), anObject, aKey);
}

- (void)rl_mulDict_removeObjectForKey:(id)aKey
{
    if (aKey) {
        [self rl_mulDict_removeObjectForKey:aKey];
        return ;
    }
    NSLog(@"RLException %@:removeObjectForKey:%@ cannot be nil", NSStringFromClass([self class]), aKey);
}

@end
