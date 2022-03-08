//
//  STKVOTest.m
//  STSourceCodeProject
//
//  Created by song on 2021/3/23.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STKVOTest.h"
#import "STKVOModel.h"
#import "STKVOBaseModel.h"
#import <objc/runtime.h>

@interface STKVOTest()

@property (nonatomic,strong)STKVOModel *model;
@property (nonatomic,strong)STKVOBaseModel *baseModel;

@end

@implementation STKVOTest

- (void)dealloc {
    //[self removeObserver:self.model forKeyPath:@"name"];
//    [self removeObserver:self.baseModel forKeyPath:@"names"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[STKVOModel alloc]init];
        self.baseModel = [[STKVOBaseModel alloc]init];

//        self.model.address = @"故宫博物院";
//        self.model.observer = self;
//        [self printClassMethon:self.model.class];
//        NSLog(@"初始化完成后类对象：model.isa指向：%@", object_getClass(self.model)); // model.isa指向：STKVOModel
//        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//        self.model.name = @"model";
//        NSLog(@"注册KVO后类对象：model.isa指向：%@", object_getClass(self.model)); // model.isa指向：NSKVONotifying_STKVOModel
//        [self printClassMethon:object_getClass(self.model)];
//        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
        
        [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//        [self.baseModel addObserver:self forKeyPath:@"names" options:NSKeyValueObservingOptionNew context:nil];

        self.model.name = @"bj";
        self.baseModel.names = [NSArray arrayWithObjects:@"张三", @"李四", nil];
//        [self printClassMethon:self.model.class];
        [self printClasses:self.model.class];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //NSLog(@"%@-%@-%@", keyPath, object, change);
}

- (void)printClassMethon:(Class)cls {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method name: %@", NSStringFromSelector(method_getName(method)));
    }
}

- (void)printClasses:(Class)cls {
    
    // 注册类的总数
    int count = objc_getClassList(NULL, 0);
    // 创建一个数组， 其中包含给定对象
    NSMutableArray *mArray = [NSMutableArray arrayWithObject:cls];
    // 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i<count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mArray addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"classes = %@", mArray);
}

@end
