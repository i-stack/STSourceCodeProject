//
//  STObjectEssenceViewController.m
//  STSourceCodeProject
//
//  Created by qcraft on 2022/2/14.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import "STObjectEssenceViewController.h"
#import "STAnimation.h"
#import <objc/message.h>
#import "STOSSpinLock.h"
#import "STMultipleReadSingleWrite.h"
#import "STPlayer.h"

@interface STObjectEssenceViewController ()

@property (nonatomic,strong)NSTimer *delayTimer;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)STAnimation *animation;

@end

@implementation STObjectEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMusic];
    [self testTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /// [self testMultipleReadSingleWrite];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.delayTimer invalidate];
}

- (void)testMethod {
//    [self.animation printName];
//    objc_msgSend(self.animation, @selector(printName));
//    ((void (*)(id, SEL))objc_msgSend)(self.animation, @selector(printName));
//    NSString *name = @"21";
//    NSString *age = @"23";
//    id cls = [STAnimation class];
//    void *obj = &cls;
//    [(__bridge id)obj printName];
//    NSLog(@"");
}

- (void)testTimer {
    // invalidate 有效
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
//    self.delayTimer = timer;
//
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"handleHideTimer");
    }];
    self.delayTimer = timer;

    // invalidate 有效
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    self.delayTimer = timer;
    
//    self.delayTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];
    
    self.delayTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"handleHideTimer");
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];
}

- (void)handleHideTimer {
    NSLog(@"handleHideTimer");
}

- (void)playMusic {
    NSString *localPath = [[NSBundle mainBundle]pathForResource:@"a189ff05e4c7b2ea1a243d9e13bcbee6" ofType:@"mp4"];
    NSURL *fileUrl = [NSURL fileURLWithPath:localPath];
    STPlayer *player = [[STPlayer alloc]initWithURL:fileUrl contentView:self.view];
}

- (void)dealloc {
    [super dealloc];
    [self.delayTimer invalidate];
    NSLog(@"STObjectEssenceViewController dealloc");
}

@end
