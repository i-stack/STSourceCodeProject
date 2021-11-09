//
//  STPerson.m
//  STInterViewProject
//
//  Created by song on 2021/11/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STPerson.h"

@implementation STPerson

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"anInvocation doesNotRecognizeSelector");
}

@end
