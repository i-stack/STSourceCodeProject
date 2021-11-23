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
#import "STPerson.h"
#import "STStudent.h"
#import "STView.h"
#import "STRootView.h"
#import "STButton.h"
#import "STRunloopViewController.h"
#import "STWebViewViewController.h"

@interface STNextViewController ()

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)STTimerTest *timer;

@end

@implementation STNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    STRootView *rootView = [[STRootView alloc]initWithFrame:self.view.bounds];
    rootView.layer.cornerRadius = 20;
    [self.view addSubview:rootView];
    
    STView *view = [[STView alloc]initWithFrame:CGRectMake(20, 0, 380, 200)];
    view.center = rootView.center;
    
    // 设置mask 会造成离屏渲染
//    CALayer *ly = [CALayer layer];
//    ly.frame = CGRectMake(0, 0, 380, 200);
//    view.layer.mask = ly;
    
    // 光栅化会造成离屏渲染
//    view.layer.shouldRasterize = YES;
    
//    view.backgroundColor = UIColor.blueColor;
    
    // 设置cornerRadius和masksToBounds 会造成离屏渲染
//    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    // 设置阴影的不透明度,shadowOpacity大于0时会造成离屏渲染
//    view.layer.shadowOpacity = 0.1;
    // 同时设置shadowPath，不会造成离屏渲染
//    CGPathRef ref = CGPathCreateWithRoundedRect(view.bounds, 1, 1, NULL);
//    view.layer.shadowPath = ref;

    // opacity = 1, 不透明
    // opacity = 0, 透明
    // opacity = (0, 1), 会造成离屏渲染
//    view.layer.opacity = 0.2;
    [rootView addSubview:view];
    
    STButton *btn = [STButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = UIColor.redColor;
    btn.frame = CGRectMake(150, 80, 100, 40);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    // 设置圆角和设置裁剪 不会造成离屏渲染
    //
    btn.imageView.layer.cornerRadius = 100.0;
    btn.imageView.layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)testExample {
    [self testWebkit];
}

- (void)testTimer {
    self.timer = [[STTimerTest alloc]init];
}

- (void)testCategory {
    STAnimation *animation = [[STAnimation alloc]init];
    [animation printName];
}

/// 重写setter方法
- (void)setName:(NSString *)name {
    @synchronized (self) {
//        if(_name != name) {
//            [_name release];
//            _name = [name retain];
//        }
    }
}

- (void)testTaggedPoint {
    dispatch_queue_t queue = dispatch_queue_create("TaggedPoint", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"0abcdefghi"];
            NSLog(@"%@",[self.name class]); // NSTaggedPointerString
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
//    NSMutableString *str = [NSMutableString stringWithFormat:@"123"];
//    mrc.name = str;
//    NSLog(@"name=%@", mrc.name);
//    [str appendString:@"abc"];
//    NSLog(@"name=%@", mrc.name);
}

- (void)testBinaryTree {
    STBinaryTreeTest *bt = [[STBinaryTreeTest alloc]init];
}

- (void)testBlock {
    STBlock *block = [[STBlock alloc]init];
}

- (void)testRuntime {
    STStudent *student = [[STStudent alloc]init];
//    [student printIsMemberOfClassClassMethod];
//    [student printIsMemberOfClassInstanceMethod];
//    [student printIsKindOfClassClassMethod];
//    [student printIsKindOfClassInstanceMethod];
//    NSString *name = @"124";
//    id person = [STPerson class];
//    void *cls = &person;
//    [(__bridge id)cls print];
}

- (void)testRunloop {
    STRunloopViewController *vc = [[STRunloopViewController alloc]initWithNibName:@"STRunloopViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testWebkit {
    STWebViewViewController *vc = [[STWebViewViewController alloc]initWithNibName:@"STWebViewViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnClick {
    NSLog(@"btnClick");
    [self testExample];
}

- (void)dealloc {
//    [self.timer invalidate];
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
