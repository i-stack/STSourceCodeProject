//
//  STAnimation.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"
#import "STBlock.h"
#import "STAnimation+STPerson.h"
#import <objc/runtime.h>

@implementation STAnimation

//+ (void)load
//{
//    NSLog(@"%@", @"STAnimation.load");
//}

//- (void)printName
//{
//
//}

- (void)unrecognizedSelectorSentToInstance {
    NSLog(@"----unrecognizedSelectorSentToInstance----");
}

void demoTestMethod(id self, SEL _cmd)
{
    NSLog(@"%@被调用...但是%@: doesNotRecognizeSelector", NSStringFromSelector(_cmd), NSStringFromSelector(_cmd));
}

void demoTestClassMethod(id self, SEL _cmd)
{
    NSLog(@"%@被调用...但是%@: doesNotRecognizeSelector", NSStringFromSelector(_cmd), NSStringFromSelector(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class], sel, (IMP)demoTestMethod, "v@:");
    return YES;
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    class_addMethod([STAnimation class], sel, (IMP)demoTestClassMethod, "v@:");
    return YES;
    return [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
//    return [[STBlock alloc]init];
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    //return [NSMethodSignature signatureWithObjCTypes:"v@:@"];;
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    anInvocation.selector = @selector(unrecognizedSelectorSentToInstance);
    [anInvocation invokeWithTarget:self];
    //[self doesNotRecognizeSelector:anInvocation.selector];
}

@end
