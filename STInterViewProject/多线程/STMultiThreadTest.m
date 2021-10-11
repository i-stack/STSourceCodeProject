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
#import "STSaleTickets.h"

@interface STMultiThreadTest()

@end

@implementation STMultiThreadTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testSaleTickets];
    }
    return self;
}

- (void)testGCD {
    STGCD *gcd = [[STGCD alloc]init];
}

- (void)testOSSpinLock {
    STOSSpinLock *lock = [[STOSSpinLock alloc]init];
}

- (void)testSaleTickets {
    STSaleTickets *ticket = [[STSaleTickets alloc]init];
}

@end
