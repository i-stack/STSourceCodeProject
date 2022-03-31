//
//  STSourceCodeProjectTests.m
//  STSourceCodeProjectTests
//
//  Created by qcraft on 2022/3/30.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STOSSpinLock.h"

@interface STSourceCodeProjectTests : XCTestCase

@property (nonatomic,strong)STOSSpinLock *spinLock;

@end

@implementation STSourceCodeProjectTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSpinLock {
    self.spinLock = [[STOSSpinLock alloc]init];
    [self.spinLock saleTickets];
}

@end
