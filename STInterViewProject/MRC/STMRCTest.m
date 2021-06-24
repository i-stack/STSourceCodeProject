//
//  STMRCTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCTest.h"
#import "STMRCModel.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import <objc/message.h>

@implementation STMRCTest

struct STMRCModel_IMPL {
    Class isa;
    NSString *_baseName;
    NSString *_baseAddress;
    NSInteger _age;
    NSString *_queueName;
};

struct objc_super2 {
    id receiver;
    Class current_class;
};

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"111");

        STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        NSLog(@"%zu", class_getInstanceSize(model.class));
        NSLog(@"%zu", malloc_size(model));
        model.age = 100;
        model.queueName = @"STMRCModel";
        [model instanceMethod];
        [model performSelector:@selector(test) withObject:@"124"];
        
        struct STMRCModel_IMPL *impl = (__bridge struct STMRCModel_IMPL *)model;
        NSLog(@"age is: %ld, name is: %@", (long)impl->_age, impl->_queueName);
        
        dispatch_queue_t queue = dispatch_queue_create("tagged point", DISPATCH_QUEUE_CONCURRENT);
        for (int i = 0; i < 10000; i++) {
            dispatch_async(queue, ^{
                self.name = [NSString stringWithFormat:@"abcde%d", i];
            });
        }
        NSLog(@"111");

        STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        NSLog(@"%zu", class_getInstanceSize(model.class));
        NSLog(@"%zu", malloc_size(model));
        struct objc_super2 *super2 = (__bridge struct objc_super2 *)([super class]);
        NSLog(@"%@", NSStringFromClass(self.class));
        NSLog(@"%@", NSStringFromClass([super class]));//(id)class_getSuperclass(objc_getClass("STMRCTest"))
        
        NSString *test = @"124";
        id cls = [STMRCModel class];
        void *obj = &cls;
        [(__bridge id)obj printQueueName];
    }
    return self;
}

@end
