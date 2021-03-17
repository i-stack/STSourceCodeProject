//
//  ViewController.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "ViewController.h"
#import "STAnimation.h"
#import "STAnimation+STPerson.h"
#import "STAnimation+STDog.h"
#import <objc/runtime.h>
#import "STBlock.h"
#import "STTimer.h"
#import "STNextViewController.h"
#import "STMRCModel.h"

@interface ViewController ()

@property (nonatomic,strong)STMRCModel *mrcModel;
@property (nonatomic,strong)NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 300, 100, 40);
    [button setBackgroundColor:UIColor.orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self testMRC];
}

- (void)buttonClick {
    [self testDisplayLink];
}

- (void)testDisplayLink {
    STNextViewController *nextVC = [[STNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:true];
}

- (void)testTaggedPoint {
    dispatch_queue_t queue = dispatch_queue_create("testTaggedPoint", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abcdefghi"];
        });
    }
}

- (void)testMRC {
    self.mrcModel = [[STMRCModel alloc]init];
}


@end
