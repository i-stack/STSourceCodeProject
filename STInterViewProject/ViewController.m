//
//  ViewController.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "ViewController.h"
#import "STNextViewController.h"

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
}

- (void)buttonClick {
    STNextViewController *nextVC = [[STNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:true];
}

@end
