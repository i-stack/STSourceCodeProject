//
//  ViewController.m
//  STAlgorithmProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "ViewController.h"
#import "STNextViewController.h"
#import "NSObject+STRuntime.h"
#import "STFileManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = self.view.center;
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *ncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ncBtn.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) + 20, 200, 100);
    [ncBtn setTitle:@"ncClick" forState:UIControlStateNormal];
    [ncBtn setBackgroundColor:UIColor.orangeColor];
    [ncBtn addTarget:self action:@selector(ncClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ncBtn];
}

- (void)testNC {
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)buttonClick {
    STNextViewController *nextVC = [[STNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:true];
}

- (void)ncClick {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"name" object:nil];
}

@end
