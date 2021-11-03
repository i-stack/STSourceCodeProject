//
//  STBlock.m
//  STInterViewProject
//
//  Created by song on 2021/1/8.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBlock.h"
#import <objc/runtime.h>

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __STBlock__init_block_impl_0 {
    struct __block_impl impl;
    struct __STBlock__init_block_desc_0* Desc;
};

struct __STBlock__init_block_desc_0 {
    size_t reserved;
    size_t Block_size;
};

@interface STBlock ()
{
    NSString *_address;
}

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)void(^block)(void);

@end

@implementation STBlock

//- (void(^)(void))block {
//    void(^STBlock)(void) = ^{
//        NSLog(@"1111");
//    };
//    return STBlock;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __block id weakSelf = self;
        self.block = ^{
            NSLog(@"%@", weakSelf);
        };
        struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)self.block;
        NSLog(@"%@", impl -> impl.isa); // __NSMallocBlock__
        self.block();
    }
    return self;
}

/**
 int age = 10;
 void(^__weak block)(void) = ^{
     // 内部使用局部变量或者OC对象并且使用weak修饰的Block __NSStackBlock__
     // NSLog(@"局部变量name=%d, OC对象_address=%@", age, self->_address);
 };
 struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)block;
 NSLog(@"%@", impl -> impl.isa); // __NSStackBlock__
 
 void(^weakBlock)(void) = block;
 struct __STBlock__init_block_impl_0 *weakImpl = (__bridge struct __STBlock__init_block_impl_0 *)weakBlock;
 NSLog(@"%@", weakImpl -> impl.isa); // __NSStackBlock__
 
 void(^strongBlock)(void) = [block copy];
 struct __STBlock__init_block_impl_0 *strongImpl = (__bridge struct __STBlock__init_block_impl_0 *)strongBlock;
 NSLog(@"%@", strongImpl -> impl.isa); // __NSMallocBlock__
 
 block();
 */

/**
 void(^block)(void) = ^{
     // 不使用任何变量、全局变量、静态变量，__NSGlobalBlock__
 };
 struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)block;
 NSLog(@"%@", impl -> impl.isa); // __NSGlobalBlock__
 block();
 */

/**
 NSString *name = @"bj";
 void(^block)(void) = ^{
     // 内部使用局部变量或者OC属性, __NSMallocBlock__
     NSLog(@"%@", name);
 };
 struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)block;
 NSLog(@"%@", impl -> impl.isa); // __NSMallocBlock__
 block();
 */
@end
