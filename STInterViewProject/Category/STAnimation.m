//
//  STAnimation.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"
#import "STAnimation+STPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation STAnimation

//+ (Class)class {
//    return self;
//}
//
//- (Class)class {
//    return objc_getClass([NSStringFromClass(self) UTF8String]);
//}

//struct objc_object {
//    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
//};

struct __rw_objc_super {
    id object;
    Class superClass;
};

- (instancetype)init {
    if (self = [super init]) {
        
//        struct __rw_objc_super objcSuper;
//        objcSuper.object = self;
//        objcSuper.superClass = [self superclass];
//
//        struct objc_object object;
//        object.isa = objc_getClass([NSStringFromClass(self.class) UTF8String]);
//
//        NSLog(@"%@ - %@", objc_msgSend((__bridge id)(&object), sel_registerName("class")), objc_msgSendSuper(&objcSuper, sel_registerName("class")));
//        NSLog(@"%@ - %@", objc_msgSendSuper(&objcSuper, sel_registerName("init")), self);
//
//        NSLog(@"%lu-%lu", sizeof(struct1), sizeof(struct3));

        
//        }
    }
    return self;
}

+ (void)load
{
    NSLog(@"STAnimation.load");
}

+ (void)initialize
{
    NSLog(@"STAnimation.initialize");
}

+ (void)print {
//    NSLog(@"%@---%@", [self printBaseAnimation]);
//    NSLog(@"%@", [super printBaseAnimation]);
    
    struct __rw_objc_super objcSuper;
    objcSuper.object = objc_getMetaClass([NSStringFromClass(self.class) UTF8String]);
    objcSuper.superClass = class_getSuperclass(self);//[self superclass];
    
    struct objc_object object;
    object.isa = objc_getMetaClass([NSStringFromClass(self.class) UTF8String]);
//    NSLog(@"%@", objc_msgSend((__bridge id)(&object), sel_registerName("printBaseAnimation")));
    NSLog(@"%@", [self printBaseAnimation]);

    NSLog(@"%@", [super printBaseAnimation]);
//    NSLog(@"%@ - %@", objc_msgSendSuper(&objcSuper, sel_registerName("printBaseAnimation")), self);
}

- (void)printName
{
    NSLog(@"Handle notification--current thread: %@", [NSThread currentThread]);
}

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
