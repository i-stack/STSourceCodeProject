//
//  STGCD.m
//  STInterViewProject
//
//  Created by song on 2021/3/17.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STGCD.h"

@interface STGCD ()

@property (nonatomic, assign)int tickets;

@end

@implementation STGCD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tickets = 10;
        [self testPrintValue];
    }
    return self;
}

- (void)testSync {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 10; i < 20; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    NSLog(@"end");
}

- (void)testSyncSerial {
    dispatch_queue_t queue = dispatch_queue_create("testSyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 10; i < 20; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    NSLog(@"end");
}

- (void)testAsync {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 10; i < 20; i++) {
            NSLog(@"%@ -- %d", [NSThread currentThread], i);
        }
    });
    NSLog(@"end");
}

- (void)testDeadLock {
    NSLog(@"1");
    dispatch_queue_t queue = dispatch_queue_create("testDeadLock", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)saleTickets {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket {
    int oldTicktes = self.tickets;
    sleep(1);
    oldTicktes--;
    self.tickets = oldTicktes;
    NSLog(@"还剩下：%d", self.tickets);
}

- (void)testPrintValue {
    __block int i = 10;
    dispatch_queue_t queue = dispatch_queue_create("testDeadLock", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"%d", i);
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        NSLog(@"3");
    });
    i = 20;
    NSLog(@"end");
}

@end
