//
//  STWeakTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STWeakTest.h"
#import "STWeakModel.h"

@implementation STWeakTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak STWeakModel *weakModel;
        NSLog(@"before: %@", weakModel);
        {
            STWeakModel *model = [[STWeakModel alloc]init];
            weakModel = model;
        }
        NSLog(@"%@", weakModel);
    }
    return self;
}

@end
