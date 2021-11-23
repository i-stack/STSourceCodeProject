//
//  STBlock.m
//  STInterViewProject
//
//  Created by song on 2021/1/8.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBlock.h"
#import <objc/runtime.h>

//struct __block_impl {
//    void *isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};
//
//struct __STBlock__init_block_impl_0 {
//    struct __block_impl impl;
//    struct __STBlock__init_block_desc_0* Desc;
//};
//
//struct __STBlock__init_block_desc_0 {
//    size_t reserved;
//    size_t Block_size;
//};

@interface STBlock ()
{
    NSString *_address;
}

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)void(^block)(void);
@property (nonatomic, strong)void(^block1)(void);
@property (nonatomic, strong)NSMutableArray *mArray;

@end

@implementation STBlock

- (instancetype)init
{
    self = [super init];
    if (self) {
//        __weak typeof(self) weakSelf = self;
//        self.block = ^{
//            __strong typeof(self) strongSelf = weakSelf;
//            weakSelf.block1 = ^{
//                NSLog(@"%@", strongSelf);
//            };
//            weakSelf.block1();
//            NSLog(@"%@", weakSelf);
//        };
//        struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)self.block;
//        NSLog(@"%@", impl -> impl.isa); // __NSMallocBlock__
//        self.block();
//
//        [self test];
        __block int m = 123;
        self.block1 = ^{
            NSLog(@"%d", m);
        };
        self.block1();
    }
    return self;
}

- (void)test {
    NSObject *objc = [NSObject new]; // 1
    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(objc)));

    void(^block1)(void) = ^{// __NSStackBlock__ 栈上block不会对objc产生强引用
        NSLog(@"---%ld--%@",CFGetRetainCount((__bridge CFTypeRef)(objc)), objc);//1
    };
    block1();

    void(^__weak block2)(void) = ^{// __NSStackBlock__
        NSLog(@"---%ld",CFGetRetainCount((__bridge CFTypeRef)(objc))); // 1
    };
    block2();

    void(^block3)(void) = [block2 copy]; // __NSMallocBlock__ 2
    block3();

    __block NSObject *obj = [NSObject new];
    void(^block4)(void) = ^{// __NSStackBlock__ 1
        NSLog(@"---%ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    };
    block4();
}

- (void)testDemo2 {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    self.mArray = arr;
    
    void(^block1)(void) = ^{
        [arr addObject:@"3"];
        [self.mArray addObject:@"a"];
        NSLog(@"KC %@",arr);
        NSLog(@"Cooci: %@",self.mArray);
    };
    [arr addObject:@"4"];
    [self.mArray addObject:@"5"];
    
    arr = nil;
    self.mArray = nil;
        
    block1();
}

- (void)testDemo3 {
    NSObject *a = [NSObject alloc];
    void(^__weak block1)(void) = nil;
    {
        void(^block2)(void) = ^{
            NSLog(@"---%@", a);
        };
        block1 = block2;
        NSLog(@"1 - %@ - %@",block1, block2);
    }
    block1();
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
     // 内部使用局部变量或者OC属性, __NSStackBlock__
     NSLog(@"%@", name);
 };
 struct __STBlock__init_block_impl_0 *impl = (__bridge struct __STBlock__init_block_impl_0 *)block;
 NSLog(@"%@", impl -> impl.isa); // __NSStackBlock__
 block();
 */
@end
