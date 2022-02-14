//
//  STMultiThreadTest.h
//  STPrincipleProject
//
//  Created by song on 2021/3/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STMultiThreadTest : NSObject

- (void)testGCD;
- (void)testOSSpinLock;
- (void)testSaleTickets;

@end

NS_ASSUME_NONNULL_END
