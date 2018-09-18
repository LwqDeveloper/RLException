//
//  NSDictionary+RLException.m
//  RLExceptionDemo
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/14.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSDictionary+RLException.h"
#import "NSObject+RLHook.h"

@implementation NSDictionary (RLException)

+ (void)rl_filterDictionary
{
    /** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1] */
    RLSwizzleInstanceMethodNames(@[@"__NSPlaceholderDictionary"], @selector(initWithObjects:forKeys:count:), @selector(rl_dict_initWithObjects:forKeys:count:));
}

- (instancetype)rl_dict_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    NSInteger index = 0;
    id ks[cnt];
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (keys[i] && objects[i]) {
            ks[index] = keys[i];
            objs[index] = objects[i];
            ++index;
        } else {
            NSLog(@"RLException %@:object or key is nil", NSStringFromClass([self class]));
            return [NSDictionary dictionary];
        }
    }
    return [self rl_dict_initWithObjects:objects forKeys:keys count:cnt];
}

@end
