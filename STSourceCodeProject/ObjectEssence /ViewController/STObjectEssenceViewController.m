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

@interface STObjectEssenceViewController ()

@property (nonatomic,strong)STAnimation *animation;

@end

@implementation STObjectEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animation = [[STAnimation alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self testMultipleReadSingleWrite];
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

@end
