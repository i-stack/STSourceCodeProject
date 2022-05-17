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

@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)STAnimation *animation;

@end

@implementation STObjectEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.animation = [[STAnimation alloc]init];
    // Do any additional setup after loading the view from its nib.
//    [STAnimation testClassMethod];
//    ((void (*)(id, SEL))objc_msgSend)(self.animation, @selector(testClassMethod));
    [self playMusic];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /// [self testMultipleReadSingleWrite];
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

- (void)testTickets {
    STOSSpinLock *lock = [[STOSSpinLock alloc]init];
    [lock saleTickets];
}

- (void)testMultipleReadSingleWrite {
    STMultipleReadSingleWrite *lock = [[STMultipleReadSingleWrite alloc]init];
    [lock testMultipleReadSingleWrite];
}

- (void)playMusic {
    NSString *localPath = [[NSBundle mainBundle]pathForResource:@"a189ff05e4c7b2ea1a243d9e13bcbee6" ofType:@"mp4"];
    NSURL *fileUrl = [NSURL fileURLWithPath:localPath];
    STPlayer *player = [[STPlayer alloc]initWithURL:fileUrl contentView:self.view];
}

- (void)dealloc {
    [super dealloc];
}

@end
