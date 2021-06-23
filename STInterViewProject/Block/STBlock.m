//
//  STBlock.m
//  STInterViewProject
//
//  Created by song on 2021/1/8.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBlock.h"

@interface STBlock ()

@property (nonatomic,assign) int propertyAge;

@end

@implementation STBlock

int globalVarAge;
static int globalStaticVarHight = 80;

//struct __block_impl {
//  void *isa;
//  int Flags;
//  int Reserved;
//  void *FuncPtr;
//};
//
//struct __STBlock__testBlock_block_impl_0 {
//  struct __block_impl impl;
//  struct __STBlock__testBlock_block_desc_0* Desc;
//  int localVarAge;
//  __STBlock__testBlock_block_impl_0(void *fp, struct __STBlock__testBlock_block_desc_0 *desc, int _localVarAge, int flags=0) : localVarAge(_localVarAge) {
//    impl.isa = &_NSConcreteStackBlock;
//    impl.Flags = flags;
//    impl.FuncPtr = fp;
//    Desc = desc;
//  }
//};

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testBlock];
    }
    return self;
}

- (void)testBlock {
    int localVarAge = 10;
    self.block = ^{
        globalVarAge = 40;
        globalStaticVarHight = 800;
        NSLog(@"%d", localVarAge);
        NSLog(@"modify value after: globalStaticVarHight = %d", globalStaticVarHight);
    };
    NSLog(@"modify value before: globalStaticVarHight = %d", globalStaticVarHight);
    self.block();
    NSLog(@"--- modify value after end: globalStaticVarHight = %d ---", globalStaticVarHight);
}

@end
