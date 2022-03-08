//
//  STBaseViewController.m
//  STSourceCodeProject
//
//  Created by qcraft on 2022/2/14.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import "STBaseViewController.h"

@interface STBaseViewController ()

@end

@implementation STBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)setupNavigationBar
{
    self.navigationController.navigationBar.translucent = YES;
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc] initWithTitle:[self testTitle]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(handleTestAction)];
    self.navigationItem.rightBarButtonItem = testItem;
}

- (NSString *)testTitle {
    return @"Test";
}

- (void)handleTestAction {
    
}

@end
