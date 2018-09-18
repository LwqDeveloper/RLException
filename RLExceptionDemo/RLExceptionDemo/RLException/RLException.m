//
//  RLException.m
//  RLExceptionDemo
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/18.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "RLException.h"
#import "NSArray+RLException.h"
#import "NSMutableArray+RLException.h"
#import "NSDictionary+RLException.h"
#import "NSMutableDictionary+RLException.h"
#import "NSObject+RLException.h"

@interface RLException ()

@property (nonatomic, assign) RLExceptionFilterType type;

@end

@implementation RLException


+ (void)rl_startFilterExceptionType:(RLExceptionFilterType)type
{
    if (type & RLExceptionFilterTypeNone) {
        return ;
    }
    if (type & RLExceptionFilterTypeObject || type & RLExceptionFilterTypeAll) {
        [NSObject rl_filterObject];
    }
    if (type & RLExceptionFilterTypeArray || type & RLExceptionFilterTypeAll) {
        [NSArray rl_filterArray];
        [NSMutableArray rl_filterMultableArray];
    }
    if (type & RLExceptionFilterTypeDictionary || type & RLExceptionFilterTypeAll) {
        [NSDictionary rl_filterDictionary];
        [NSMutableDictionary rl_filterMultableDictionary];
    }
}


@end
