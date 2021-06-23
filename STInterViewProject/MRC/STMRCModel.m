//
//  STMRCModel.m
//  Category
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCModel.h"
#import <objc/runtime.h>

@interface STMRCModel()

@end

@implementation STMRCModel

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSString *str1 = @"123";
//        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str1);
//        NSString *str2 = [str1 copy];
//        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str2);
//        NSMutableString *str3 = [str1 mutableCopy];
//        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str3);
    }
    return self;
}

- (void)printQueueName {
    NSLog(@"current queue name is: %@", self.queueName);
}

- (void)instanceMethod {
    NSLog(@"instanceMethod");
}

+ (void)classMethod {
    NSLog(@"classMethod");
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    Method aMethod = class_getClassMethod(self, @selector(st_unrecognizedSelectorSentToClass));
    class_addMethod(object_getClass(self), sel, method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
    return YES;
}

+ (void)st_unrecognizedSelectorSentToClass {
    NSLog(@"unrecognized selector sent to class");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    Method aMethod = class_getInstanceMethod(self, @selector(st_unrecognizedSelectorSentToInstance:));
    class_addMethod(self, sel, method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
    return YES;
}

- (void)st_unrecognizedSelectorSentToInstance:(NSString *)selName {
    NSLog(@"unrecognized selector sent to instance");
}

@end
