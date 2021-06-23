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

@interface STMRCTest()

@property (nonatomic,weak)STMRCModel *model;

@property (nonatomic,assign)int value;

@property (nonatomic,copy)NSString *name;

@end

@implementation STMRCTest

@synthesize name = _name;

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
//        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//        self.model = [[[STMRCModel alloc]init]autorelease];
//        NSLog(@"%zu", class_getInstanceSize(self.model.class));
//        NSLog(@"%zu", malloc_size(self.model));
//        self.model.age = 100;
//        self.model.queueName = @"STMRCModel";
//        [self.model instanceMethod];
//        [self.model performSelector:@selector(test) withObject:@"124"];
//
//        struct STMRCModel_IMPL *impl = (__bridge struct STMRCModel_IMPL *)self.model;
//        NSLog(@"age is: %ld, name is: %@", (long)impl->_age, impl->_queueName);
//
//        struct objc_super2 *super2 = (__bridge struct objc_super2 *)([super class]);
//        NSLog(@"%@", NSStringFromClass(self.class));
//        NSLog(@"%@", NSStringFromClass([super class]));//(id)class_getSuperclass(objc_getClass("STMRCTest"))
//
//        NSString *test = @"124";
//        id cls = [STMRCModel class];
//        void *obj = &cls;
//        [(__bridge id)obj printQueueName];
//
//        [pool drain];
        
//        id model = [[STMRCModel alloc]init];
//        NSLog(@"%d", [model isMemberOfClass:[model class]]);// 1
//        NSLog(@"%d", [model isMemberOfClass:[STMRCModel class]]); // 1
//        NSLog(@"%d", [model isMemberOfClass:[STMRCBaseModel class]]); // 0
//        NSLog(@"%d", [model isMemberOfClass:[NSObject class]]); // 0
//        NSLog(@"%d", [model isMemberOfClass:object_getClass(model)]);// 1
//        NSLog(@"%d", [model isMemberOfClass:object_getClass([model class])]); // 0
//        NSLog(@"%d", [model isMemberOfClass:object_getClass([STMRCModel class])]); // 0
//        NSLog(@"%d", [model isMemberOfClass:object_getClass([STMRCBaseModel class])]); // 0
//        NSLog(@"%d", [model isMemberOfClass:object_getClass([NSObject class])]); // 0
//        NSLog(@"------");
//
//        NSLog(@"%d", [STMRCModel isMemberOfClass:[model class]]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:[STMRCModel class]]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:[STMRCBaseModel class]]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:[NSObject class]]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:object_getClass(model)]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:object_getClass([model class])]); // 1
//        NSLog(@"%d", [STMRCModel isMemberOfClass:object_getClass([STMRCModel class])]); // 1
//        NSLog(@"%d", [STMRCModel isMemberOfClass:object_getClass([STMRCBaseModel class])]); // 0
//        NSLog(@"%d", [STMRCModel isMemberOfClass:object_getClass([NSObject class])]); // 0
//        NSLog(@"------");
//
//        NSLog(@"%d", [model isKindOfClass:[model class]]); // 1
//        NSLog(@"%d", [model isKindOfClass:[STMRCModel class]]); // 1
//        NSLog(@"%d", [model isKindOfClass:[STMRCBaseModel class]]); // 1
//        NSLog(@"%d", [model isKindOfClass:[NSObject class]]); // 1
//        NSLog(@"%d", [model isKindOfClass:object_getClass(model)]); // 1
//        NSLog(@"%d", [model isKindOfClass:object_getClass([model class])]); // 0
//        NSLog(@"%d", [model isKindOfClass:object_getClass([STMRCModel class])]); // 0
//        NSLog(@"%d", [model isKindOfClass:object_getClass([STMRCBaseModel class])]); // 0
//        NSLog(@"%d", [model isKindOfClass:object_getClass([NSObject class])]); // 0
//        NSLog(@"------");
//
//        NSLog(@"%d", [STMRCModel isKindOfClass:[model class]]); // 0
//        NSLog(@"%d", [STMRCModel isKindOfClass:[STMRCModel class]]); // 0
//        NSLog(@"%d", [STMRCModel isKindOfClass:[STMRCBaseModel class]]); // 0
//        NSLog(@"%d", [STMRCModel isKindOfClass:[NSObject class]]); // 1
//        NSLog(@"%d", [STMRCModel isKindOfClass:object_getClass(model)]); // 0
//        NSLog(@"%d", [STMRCModel isKindOfClass:object_getClass([model class])]); // 1
//        NSLog(@"%d", [STMRCModel isKindOfClass:object_getClass([STMRCModel class])]); // 1
//        NSLog(@"%d", [STMRCModel isKindOfClass:object_getClass([STMRCBaseModel class])]); // 1
//        NSLog(@"%d", [STMRCModel isKindOfClass:object_getClass([NSObject class])]); // 1
        
        dispatch_queue_t queue = dispatch_queue_create("tagged point", DISPATCH_QUEUE_CONCURRENT);
        for (int i = 0; i < 10000; i++) {
            dispatch_async(queue, ^{
                self.name = [NSString stringWithFormat:@"abcde%d", i];
            });
        }
    }
    return self;
}

//- (void)setName:(NSString *)name {
//    @synchronized (self) {
//        if (_name != name) {
//            [_name release];
//            _name = [name retain];
//        }
//    }
//}

- (NSString *)name {
    return _name;
}

@end
