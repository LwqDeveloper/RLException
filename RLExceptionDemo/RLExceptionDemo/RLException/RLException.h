//
//  RLException.h
//  RLExceptionDemo
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/18.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RLExceptionFilterType) {
    RLExceptionFilterTypeNone = 0,
    RLExceptionFilterTypeObject = 1 << 1,
    RLExceptionFilterTypeArray = 1 << 2,
    RLExceptionFilterTypeDictionary = 1 << 3,
    RLExceptionFilterTypeAll = RLExceptionFilterTypeObject | RLExceptionFilterTypeArray | RLExceptionFilterTypeDictionary,
};

@interface RLException : NSObject

+ (void)rl_startFilterExceptionType:(RLExceptionFilterType)type;

@end
