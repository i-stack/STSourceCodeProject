//
//  STMultiThreadTest.m
//  STSourceCodeProject
//
//  Created by song on 2021/3/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMultiThreadTest.h"
#import "STGCD.h"
#import "STOSSpinLock.h"

@interface STMultiThreadTest() {
    STGCD *gcd;
    STOSSpinLock *lock;
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
    
}

@end
