//
//  STKVOTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/23.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STKVOTest.h"
#import "STKVOModel.h"
#import <objc/runtime.h>

@interface STKVOTest()

@property (nonatomic,strong)STKVOModel *model;

@end

@implementation STKVOTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[STKVOModel alloc]init];
        self.model.address = @"故宫博物院";
        self.model.observer = self;
        [self printClassMethon:self.model.class];
        NSLog(@"初始化完成后类对象：model.isa指向：%@", object_getClass(self.model)); // model.isa指向：STKVOModel
        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
        self.model.name = @"model";
        NSLog(@"注册KVO后类对象：model.isa指向：%@", object_getClass(self.model)); // model.isa指向：NSKVONotifying_STKVOModel
        [self printClassMethon:object_getClass(self.model)];
        
        [self.model addObserver:self forKeyPath:@"_age" options:NSKeyValueObservingOptionNew context:nil];
        [self.model setAge:20];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@-%@-%@", keyPath, object, change);
}

- (void)printClassMethon:(Class)cls {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method name: %@", NSStringFromSelector(method_getName(method)));
    }
}

@end
