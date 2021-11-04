//
//  STTimerTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STTimerTest.h"
#import <UIKit/UIKit.h>
#import "STProxy.h"
#import "STTimer.h"

@interface STTimerTest ()

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) dispatch_source_t cgdTimer;
@property(nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation STTimerTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testGCD];
    }
    return self;
}

- (void)testTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[STProxy proxyWithTarget:self] selector:@selector(timerPrint) userInfo:nil repeats:true];
    
//    self.displayLink = [CADisplayLink displayLinkWithTarget:[STProxy proxyWithTarget:self] selector:@selector(displayLinkPrint)];
//    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
    
    //  - (void)invalidate {
    //      if (self.timer) {
    //          [self.timer invalidate];
    //          self.timer = nil;
    //      }
    //  }
    
    // NSTimer 创建方式一
    // 需要self.timer所在类对象调用 invalidate后，self.timer所在类才会走dealloc方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerPrint) userInfo:nil repeats:true];

    // NSTimer 创建方式二
    // 无需self.timer所在类对象调用 invalidate，使用Block的方式，self.timer不会对 self 进行强引用
    __weak typeof(self)weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerPrint];
    }];

    // NSTimer 创建方式三
    // 1、需要将NSTimer对象添加到定时器中，NSTimer才能执行
    // 2、需要self.timer所在类对象调用 invalidate后，self.timer所在类才会走dealloc方法
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerPrint) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // NSTimer 创建方式四
    // 1、需要将NSTimer对象添加到定时器中，NSTimer才能执行
    // 2、需要self.timer所在类对象调用 invalidate后，self.timer所在类才会走dealloc方法
    NSDate *fireDate = [[NSDate alloc]initWithTimeIntervalSinceNow:5];
    self.timer = [[NSTimer alloc]initWithFireDate:fireDate interval:1 target:self selector:@selector(timerPrint) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // NSTimer 创建方式五
    // 无需self.timer所在类对象调用 invalidate，使用Block的方式，self.timer不会对 self 进行强引用
    self.timer = [[NSTimer alloc]initWithFireDate:fireDate interval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerPrint];
    }];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)testTimerLocal {
    NSTimer *localTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerPrintLocal) userInfo:nil repeats:true];
    NSLog(@"%@", localTimer);
//    [NSRunLoop.currentRunLoop addTimer:newTimer forMode:NSRunLoopCommonModes];
//    [newTimer fire];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerPrintLocal) userInfo:nil repeats:true];
}

- (void)timerPrint {
    NSLog(@"%s", __func__);
}

- (void)timerPrintLocal {
    NSLog(@"%s", __func__);
}

- (void)testDisplayLink {
    // 保证调用评论和屏幕刷新帧率一致，60FPS
    /* Create a new display link object for the main display. It will
     * invoke the method called 'sel' on 'target', the method has the
     * signature '(void)selector:(CADisplayLink *)sender'. */
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkPrint)];
    /* Adds the receiver to the given run-loop and mode. Unless paused, it
     * will fire every vsync until removed. Each object may only be added
     * to a single run-loop, but it may be added in multiple modes at once.
     * While added to a run-loop it will implicitly be retained. */
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
}

- (void)displayLinkPrint {
    NSLog(@"%s", __func__);
}

- (void)testGCD {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("GCD_timer", DISPATCH_QUEUE_SERIAL);
    self.cgdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, serialQueue);
    dispatch_source_set_timer(self.cgdTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.cgdTimer, ^{
        NSLog(@"GCD_timer");
    });
    dispatch_resume(self.cgdTimer);
}

- (void)testAsyncTimer {
    
}

- (void)invalidate {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }

    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)dealloc
{
    [self invalidate];
    
    NSLog(@"%@-%s", NSStringFromClass(self.class), __func__);
}

@end
