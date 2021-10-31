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
#import "STBlock.h"

@interface STNextViewController ()

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)STTimerTest *timer;

@end

@implementation STNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self testExample];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)testExample {
    [self testBlock];
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

- (void)testBlock {
    STBlock *block = [[STBlock alloc]init];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

@end
