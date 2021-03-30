//
//  STGCD.m
//  STInterViewProject
//
//  Created by song on 2021/3/17.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STGCD.h"
#import <libkern/OSAtomic.h>

@interface STGCD ()
{
    dispatch_queue_t concurrentQueue;
    NSMutableDictionary *_dataDict;
}

@property (nonatomic,assign)int tickets;

@property (nonatomic,strong)NSLock *lock;
@property (nonatomic,assign)OSSpinLock spinLock;

@end

@implementation STGCD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [[NSLock alloc]init];
        self.spinLock = OS_SPINLOCK_INIT;
        self.tickets = 10;
        _dataDict = [NSMutableDictionary dictionary];
        concurrentQueue = dispatch_queue_create("testBarrier", DISPATCH_QUEUE_CONCURRENT);
        [self testSemaphore];
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
    NSLog(@"1");
    dispatch_async(queue, ^{ // async不会阻塞线程，会往下执行
        NSLog(@"2");
    });
    NSLog(@"3");
    dispatch_sync(queue, ^{ // sync会阻塞线程，执行当前任务，因为是串行队列，想要打印4，必须等待队列前面的任务执行完成
        NSLog(@"4");
    });
    NSLog(@"5");
    // 1
    // 3
    // 2
    // 4
    // 5
}

- (void)testAsync {
    NSLog(@"1");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 100; i++) {
            sleep(0.01);
        }
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 100; i++) {
            sleep(0.01);
        }
        NSLog(@"3");
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 100; i++) {
            sleep(0.01);
        }
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 100; i++) {
            sleep(0.01);
        }
        NSLog(@"5");
    });
    NSLog(@"6");
    dispatch_async(queue, ^{
        NSLog(@"7");
    });
    dispatch_async(queue, ^{
        NSLog(@"8");
    });
    dispatch_async(queue, ^{
        NSLog(@"9");
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
        for (int i = 0; i < 10; i++) {
            [self rebackTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket {
//    OSSpinLockLock(&_spinLock);
    [self.lock lock];
    int oldTicktes = self.tickets;
    sleep(1);
    oldTicktes--;
    self.tickets = oldTicktes;
    NSLog(@"剩余票数：%d票", self.tickets);
    [self.lock unlock];
//    OSSpinLockUnlock(&_spinLock);
}

- (void)rebackTicket {
    [self.lock lock];
    self.tickets++;
    NSLog(@"剩余票数：%d票", self.tickets);
    [self.lock unlock];
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

- (void)testBarrier {
    NSLog(@"dispatch_barrier_async begin --- %@", [NSThread currentThread]);
    dispatch_barrier_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    });
    NSLog(@"barrier_async_end --- %@", [NSThread currentThread]);
    dispatch_barrier_sync(concurrentQueue, ^{
        for (int i = 11; i < 20; i++) {
            NSLog(@"%d --- %@", i, [NSThread currentThread]);
        }
    });
    NSLog(@"barrier_sync_end --- %@", [NSThread currentThread]);
}

- (void)testMultiRead {
    for (int i = 0; i < 10; i++) {
        [self writeData:[NSString stringWithFormat:@"%d", i] forKey:[NSString stringWithFormat:@"%d", i]];
    }
}

- (void)readDataForKey:(NSString *)key {
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"%@", _dataDict[key]);
    });
}

- (void)writeData:(NSString *)value forKey:(NSString *)key {
    dispatch_barrier_async(concurrentQueue, ^{
        self->_dataDict[key] = value;
    });
}

- (void)testPrintQueue {
    dispatch_queue_t queue = dispatch_queue_create("testPrintQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue, ^{
//        sleep(5);
//        NSLog(@"A");
//    });
//    dispatch_sync(queue, ^{
//        sleep(2);
//        NSLog(@"B");
//    });
//    dispatch_sync(queue, ^{
//        sleep(3);
//        NSLog(@"C");
//    });
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_wait(group, 5);
    NSLog(@"A");
    dispatch_group_wait(group, 2);
    NSLog(@"B");
    dispatch_group_wait(group, 3);
    dispatch_group_notify(group, queue, ^{
        NSLog(@"C");
    });
}

- (void)testSemaphore {
    __block int number = 0;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            number++;
        }
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"%d", number);
}

@end
