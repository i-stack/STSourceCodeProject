//
//  STBaseAnimation.m
//  STSourceCodeProject
//
//  Created by song on 2021/3/17.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBaseAnimation.h"

@implementation STBaseAnimation

+ (id)printBaseAnimation {
    NSLog(@"%s", __func__);
    return self;
}

//- (void)printName {
//    NSLog(@"%s", __func__);
//}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

@end
