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
