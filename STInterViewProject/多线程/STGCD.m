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
        [self saleTickets];
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

@end
