//
//  NSObject+RLException.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "NSObject+RLException.h"
#import "NSObject+RLHook.h"
#import <objc/runtime.h>

@interface UnrecognizedSelectorHandle : NSObject

@property(nonatomic,readwrite,weak)id fromObject;

@end

@implementation UnrecognizedSelectorHandle

void unrecognizedSelector(UnrecognizedSelectorHandle* self, SEL _cmd){
    NSString* message = [NSString stringWithFormat:@"RLObject unrecognized selector class:%@ and selector:%@",[self.fromObject class],NSStringFromSelector(_cmd)];
    NSLog(@"%@",message);
}

@end

@implementation NSObject (RLException)

+ (void)rl_filterObject
{
    /** -[__NSCFNumber length]: unrecognized selector sent to instance 0xb000000000000022 */
    RLSwizzleInstanceMethod([self class], @selector(forwardingTargetForSelector:), @selector(rl_forwardingTargetForSelector:));
}

- (id)rl_forwardingTargetForSelector:(SEL)aSelector
{
    NSMethodSignature* sign = [self methodSignatureForSelector:aSelector];
    if (!sign) {
        id stub = [UnrecognizedSelectorHandle new];
        [stub setFromObject:self];
        class_addMethod([stub class], aSelector, (IMP)unrecognizedSelector, "v@:");
        return stub;
    }
    return [self rl_forwardingTargetForSelector:aSelector];
}

@end
