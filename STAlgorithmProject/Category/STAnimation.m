//
//  STAnimation.m
//  STAlgorithmProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"
#import "STAnimation+STPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation STAnimation

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (void)load
{
    NSLog(@"%s", __func__);
}

//+ (void)initialize
//{
//    NSLog(@"%s", __func__);
//}

- (void)printName
{
    NSLog(@"%s", __func__);
}

@end
