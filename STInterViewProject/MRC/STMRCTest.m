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
#import <objc/message.h>

@implementation STMRCTest

struct STMRCModel_IMPL {
    Class isa;
    NSString *_baseName;
    NSString *_baseAddress;
    NSInteger _age;
    NSString *_queueName;
};

struct objc_super2 {
    id receiver;
    Class current_class;
};

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"111");

        STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        NSLog(@"%zu", class_getInstanceSize(model.class));
        NSLog(@"%zu", malloc_size(model));
        model.age = 100;
        model.queueName = @"STMRCModel";
        [model instanceMethod];
        [model performSelector:@selector(test) withObject:@"124"];
        
        struct STMRCModel_IMPL *impl = (__bridge struct STMRCModel_IMPL *)model;
        NSLog(@"age is: %ld, name is: %@", (long)impl->_age, impl->_queueName);
    }
    return self;
}

@end
