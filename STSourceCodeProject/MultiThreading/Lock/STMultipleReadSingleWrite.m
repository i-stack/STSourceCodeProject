//
//  STMultipleReadSingleWrite.m
//  STSourceCodeProject
//
//  Created by song on 2021/10/11.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMultipleReadSingleWrite.h"
#import <pthread.h>

@interface STMultipleReadSingleWrite ()
{
    pthread_rwlock_t _rwlock;
    dispatch_queue_t _concurrent_queue;
    NSMutableDictionary *_dataSourcesDic;
}

@end

@implementation STMultipleReadSingleWrite

- (instancetype)init
{
    self = [super init];
    if (self) {
        pthread_rwlock_init(&_rwlock, NULL);
        _dataSourcesDic = [NSMutableDictionary dictionary];
        _concurrent_queue = dispatch_queue_create("multiple read single write", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    NSLog(@"有新任务将要读取");
    pthread_rwlock_rdlock(&_rwlock);
    NSLog(@"已读取");
    id obj = [_dataSourcesDic objectForKey:key];
    pthread_rwlock_unlock(&_rwlock);
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    NSLog(@"有新数据将要写入");
    pthread_rwlock_wrlock(&_rwlock);
    NSLog(@"已写入");
    [_dataSourcesDic setObject:obj forKey:key];
    pthread_rwlock_unlock(&_rwlock);
}

- (void)testMultipleReadSingleWrite {
    dispatch_async(_concurrent_queue, ^{
        for (int i = 0; i < 10; i++) {
            [self setObject:@(i) forKey:[NSString stringWithFormat:@"%d", i]];
        }
    });
    
    dispatch_async(_concurrent_queue, ^{
        for (int i = 0; i < 50; i++) {
            [self objectForKey:[NSString stringWithFormat:@"%d", i]];
        }
    });
    
    dispatch_async(_concurrent_queue, ^{
        for (int i = 0; i < 20; i++) {
            [self setObject:@(i) forKey:[NSString stringWithFormat:@"%d", i]];
        }
    });
}

@end
