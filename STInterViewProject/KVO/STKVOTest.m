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

@property (nonatomic,strong)STKVOModel *model1;
@property (nonatomic,strong)STKVOModel *model2;

@end

@implementation STKVOTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model1 = [[STKVOModel alloc]init];
        self.model2 = [[STKVOModel alloc]init];
        NSLog(@"初始化完成后类对象：\nmodel1.isa指向：%@\nmodel2.isa指向：%@", object_getClass(self.model1), object_getClass(self.model2));
        NSLog(@"初始化完成后元类对象：\nmodel1.isa指向：%@\nmodel2.isa指向：%@", object_getClass(object_getClass(self.model1)), object_getClass(object_getClass(self.model2)));
        [self.model1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
        self.model1.name = @"model1";
//        self.model2.name = @"model2";
//        NSLog(@"注册KVO后类对象：\nmodel1.isa指向：%@\nmodel2.isa指向：%@", object_getClass(self.model1), object_getClass(self.model2));
//        NSLog(@"注册KVO后元类对象：\nmodel1.isa指向：%@\nmodel2.isa指向：%@", object_getClass(object_getClass(self.model1)), object_getClass(object_getClass(self.model2)));
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    NSLog(@"%@-%@-%@", keyPath, object, change);
}

@end
