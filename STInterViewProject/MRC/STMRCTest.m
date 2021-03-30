//
//  STMRCTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCTest.h"
#import "STMRCModel.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@implementation STMRCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"111");

        STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        NSLog(@"%zu", class_getInstanceSize(model.class));
        NSLog(@"%zu", malloc_size(model));
    }
    return self;
}

@end
