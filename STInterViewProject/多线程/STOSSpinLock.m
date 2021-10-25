//
//  STOSSpinLock.m
//  STInterViewProject
//
//  Created by song on 2021/3/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STOSSpinLock.h"
#import <libkern/OSAtomic.h>

@interface STOSSpinLock()
{
    OSSpinLock _lock;
}

@property (nonatomic,assign)int tickets;

@end

@implementation STOSSpinLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_SPINLOCK_INIT;
        self.tickets = 100;
        [self saleTickets];
    }
    return self;
}

- (void)saleTickets {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket {
    OSSpinLockLock(&_lock);
    int oldTicktes = self.tickets;
    sleep(.2);
    oldTicktes--;
    self.tickets = oldTicktes;
    NSLog(@"还剩下：%d--%@", self.tickets, [NSThread currentThread]);
    OSSpinLockUnlock(&_lock);
}

@end
