//
//  STOSSpinLock.m
//  STSourceCodeProject
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
        for (int i = 0; i < 2; i++) {
            [self refundTicket];
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
        for (int i = 0; i < 10; i++) {
            [self refundTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self refundTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 1; i++) {
            [self refundTicket];
        }
    });
}

- (void)saleTicket {
    OSSpinLockLock(&_lock);
    int oldTicktes = self.tickets;
    sleep(.2);
    oldTicktes--;
    self.tickets = oldTicktes;
    NSLog(@"余票：%d张", self.tickets);
    OSSpinLockUnlock(&_lock);
}

- (void)refundTicket {
    OSSpinLockLock(&_lock);
    int oldTicktes = self.tickets;
    sleep(.2);
    oldTicktes++;
    NSLog(@"退票:%d张，余票：%d张", oldTicktes - self.tickets, oldTicktes);
    self.tickets = oldTicktes;
    OSSpinLockUnlock(&_lock);
}

@end
