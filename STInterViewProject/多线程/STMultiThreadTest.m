//
//  STMultiThreadTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMultiThreadTest.h"
#import "STGCD.h"
#import "STOSSpinLock.h"

@implementation STMultiThreadTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testGCD];
    }
    return self;
}

- (void)testGCD {
    STGCD *gcd = [[STGCD alloc]init];
}

- (void)testOSSpinLock {
    STOSSpinLock *lock = [[STOSSpinLock alloc]init];
}

@end
