//
//  STAnimation+STPerson.m
//  STAlgorithmProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation+STPerson.h"
#import <objc/runtime.h>

@implementation STAnimation (STPerson)

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

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, @selector(name));
}

+ (void)printAge
{
    NSLog(@"%s", __func__);
}

@end
