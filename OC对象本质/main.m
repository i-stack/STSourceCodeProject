//
//  main.m
//  OC对象本质
//
//  Created by song on 2021/7/1.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

struct NSObject_IMPL {
    Class isa;
};

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    int _no;
    int _year;
    int _age;
    int _weight;
    NSString *_name;
    NSString *_name1;
    NSString *_name2;
    double _height;
};

struct Student_IMPL {
    struct Person_IMPL Person_IVARS;
    int _stuName;
};

@interface Person : NSObject {
//    int _age;
//    NSString *_name;
//    int _no;
//    double _height;
//    int _year;
//    NSString *_name1;
//    int _weight;
//    NSString *_name2;
    
//    int _age;
//    int _no;
//    int _year;
//    int _weight;
//    NSString *_name2;
//    NSString *_name;
//    NSString *_name1;
//    double _height;
}
//@property(nonatomic, assign) int no;
//@property(nonatomic, strong) NSString *name;
//@property(nonatomic, assign) int weight;
//@property(nonatomic, strong) NSString *name1;
//@property(nonatomic, assign) int age;
//@property(nonatomic, strong) NSString *name2;
//@property(nonatomic, assign) int year;
//@property(nonatomic, assign) double height;

@property(nonatomic, assign) int no;
@property(nonatomic, assign) int year;
@property(nonatomic, assign) int age;
@property(nonatomic, assign) int weight;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *name1;
@property(nonatomic, strong) NSString *name2;
@property(nonatomic, assign) double height;

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.no = 10;
        self.year = 2021;
        self.age = 20;
        self.weight = 130;
        self.name = @"name";
        self.name1 = @"name1";
        self.name2 = @"name2";
        self.height = 170;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ --- %@", self.name, self.name1];
}

@end

@interface Student : Person {
    int _stuName;
}

@end

@implementation Student

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *model = [[Person alloc]init];
        
        NSLog(@"%@", model.description);
        NSLog(@"%zu", class_getInstanceSize(model.class));
        NSLog(@"%zu", malloc_size(CFBridgingRetain(model)));
        
        struct Person_IMPL *object = (__bridge struct Person_IMPL *)(model);
        NSLog(@"no=%d-year=%d-age=%d-weight=%d-name=%@-name1=%@-name2=%@-height=%d", object -> _no, object -> _year, object -> _age, object -> _weight, object -> _name, object -> _name1, object -> _name2, object -> _weight);
        
        Student *student = [[Student alloc]init];
        
        struct Student_IMPL *impl = (__bridge struct Student_IMPL *)(student);
        NSLog(@"no=%d-year=%d-age=%d-weight=%d-name=%@-name1=%@-name2=%@-height=%d", impl -> Person_IVARS._no, impl -> Person_IVARS._year, impl -> Person_IVARS._age, impl -> Person_IVARS._weight, impl -> Person_IVARS._name, impl -> Person_IVARS._name1, impl -> Person_IVARS._name2, impl -> Person_IVARS._weight);
        
        BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
        BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
        BOOL re3 = [(id)[Student class] isKindOfClass:[Student class]];
        BOOL re4 = [(id)[Student class] isMemberOfClass:[Student class]];
        NSLog(@" re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);

        BOOL re5 = [(id)[NSObject alloc] isKindOfClass:[NSObject class]];
        BOOL re6 = [(id)[NSObject alloc] isMemberOfClass:[NSObject class]];
        BOOL re7 = [(id)[Student alloc] isKindOfClass:[Student class]];
        BOOL re8 = [(id)[Student alloc] isMemberOfClass:[Student class]];
        NSLog(@" re5 :%hhd\n re6 :%hhd\n re7 :%hhd\n re8 :%hhd\n",re5,re6,re7,re8);
    }
    return 0;
}
