//
//  STProxy.m
//  STAlgorithmProject
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STProxy.h"

@interface STProxy ()

@property (nonatomic, weak)id target;

@end

@implementation STProxy

+ (instancetype)proxyWithTarget:(id)target {
    STProxy *proxy = [STProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
