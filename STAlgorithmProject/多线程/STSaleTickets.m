//
//  STSaleTickets.m
//  STAlgorithmProject
//
//  Created by song on 2021/10/11.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STSaleTickets.h"

@interface STSaleTickets ()

@property (nonatomic,assign)int tickets;

@property (nonatomic,strong)NSLock *lock;

@end

@implementation STSaleTickets

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [[NSLock alloc]init];
        self.tickets = 50;
        [self saleTickets];
    }
    return self;
}

- (void)saleTickets {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket {
    [self.lock lock];
    int oldTicktes = self.tickets;
    sleep(.2);
    oldTicktes--;
    self.tickets = oldTicktes;
    NSLog(@"还剩下：%d--%@", self.tickets, [NSThread currentThread]);
    [self.lock unlock];
}

@end
