//
//  STNextViewController.m
//  STInterViewProject
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STNextViewController.h"
#import "STTimerTest.h"
#import "STAnimation.h"
#import <objc/runtime.h>
#import "STKVCTest.h"
#import "STKVOTest.h"
#import "STMultiThreadTest.h"
#import "STWeakTest.h"
#import "STMRCTest.h"
#import "STMRCModel.h"
#import "STBinaryTreeTest.h"

@interface STNextViewController ()

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)STTimerTest *timer;

@end

@implementation STNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self testExample];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printName:) name:@"" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNameAndObject:) name:nil object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printName:) name:@"NotificationName" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:@1];

//    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        NSLog(@"Begin post notification--current thread1: %@", [NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:@1];
//        NSLog(@"End post notification--current thread1: %@", [NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"Begin post notification--current thread2: %@", [NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:@2];
//        NSLog(@"End post notification--current thread2: %@", [NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"Begin post notification--current thread3: %@", [NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:@3];
//        NSLog(@"End post notification--current thread3: %@", [NSThread currentThread]);
//    });
}

- (void)testExample {
    [self testKVO];
}

- (void)testTimer {
    self.timer = [[STTimerTest alloc]init];
    [self.timer testTimerLocal];
}

- (void)testCategory {
    STAnimation *animation = [[STAnimation alloc]init];
    [animation printName];
}

- (void)testTaggedPoint {
    dispatch_queue_t queue = dispatch_queue_create("testTaggedPoint", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abcdefghi"];
        });
    }
}

- (void)testMultiThreadTest {
    STMultiThreadTest *multiThreadTest = [[STMultiThreadTest alloc]init];
}

- (void)testKVC {
    STKVCTest *kvc = [[STKVCTest alloc]init];
}

- (void)testKVO {
    STKVOTest *kvo = [[STKVOTest alloc]init];
}

- (void)testWeak {
    STWeakTest *weak = [[STWeakTest alloc]init];
}

- (void)testMRC {
    STMRCTest *mrc = [[STMRCTest alloc]init];
}

- (void)testBinaryTree {
    STBinaryTreeTest *bt = [[STBinaryTreeTest alloc]init];
}

- (void)printName:(NSNotification *)info {
    NSLog(@"Handle notification info = %@--current thread: %@", info.object, [NSThread currentThread]);
}

- (void)notificationName {
    NSLog(@"notificationName is nil");
}

- (void)notificationNameAndObject:(NSNotification *)info {
    NSLog(@"notificationName and object are both nil --- %@", info);
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end
