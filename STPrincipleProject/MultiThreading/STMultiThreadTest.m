//
//  STMultiThreadTest.m
//  STPrincipleProject
//
//  Created by song on 2021/3/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMultiThreadTest.h"
#import "STGCD.h"
#import "STOSSpinLock.h"
#import "STSaleTickets.h"

@interface STMultiThreadTest() {
    STGCD *gcd;
    STOSSpinLock *lock;
    STSaleTickets *ticket;
}

@end

@implementation STMultiThreadTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)testGCD {
    gcd = [[STGCD alloc]init];
}

- (void)testOSSpinLock {
    lock = [[STOSSpinLock alloc]init];
}

- (void)testSaleTickets {
    ticket = [[STSaleTickets alloc]init];
}

@end
