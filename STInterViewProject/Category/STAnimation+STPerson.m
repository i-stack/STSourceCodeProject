//
//  STAnimation+STPerson.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation+STPerson.h"
#import <objc/runtime.h>

@implementation STAnimation (STPerson)

//+ (void)load
//{
//    NSLog(@"%@", @"STAnimation+STPerson.load");
//}

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, @selector(name));
}

//- (void)printName
//{
//    NSLog(@"%@", @"STAnimation+STPerson");
//}

+ (void)printAge
{
    NSLog(@"%@", @"STAnimation+STPerson.age");
}

@end
