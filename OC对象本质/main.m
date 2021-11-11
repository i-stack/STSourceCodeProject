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

//struct method_t {
//    SEL name; // 函数名
//    const char *types; // 函数返回值、参数类型编码
//    MethodListIMP imp; // 指向函数的指针
//}
//
//struct cache_t {
//    
//}
//
struct class_ro_t;
struct method_array_t;
struct class_data_bits_t;
//
//typedef struct objc_class *Class;
//
//struct objc_class {
//    Class ISA;
//    Class superclass;
//    cache_t cache;             // formerly cache pointer and vtable
//    class_data_bits_t bits;    // class_r
//}
//



struct method_t {
    /**
     *  typedef struct objc_selector *SEL;
     *
     *  (1)SEL代表方法\函数名，一般叫做选择器，底层结构跟char *类似；
     *
     *  (2)通过@selector()和sel_registerName()可以获得SEL；
     *
     *  (3)通过sel_getName()和NSStringFromSelector()可以将SEL转成字符串；
     *
     *  (4)不同类中相同名字的方法，所对应的方法选择器是相同的；
     */
    SEL name;
    
    const char *types; // 函数返回值、参数类型编码
    
    /**
     *  typedef id _Nullable (*IMP)(id _Nonnull, SEL _Nonnull, ...);
     *
     *  指向函数的指针
     */
    IMP imp;
};

typedef struct method_array_t {
    
}method_array_t;

typedef struct property_array_t {
    
}property_array_t;

typedef struct protocol_array_t {
    
}protocol_array_t;

typedef struct method_list_t {
    
}method_list_t;

typedef struct property_list_t {
    
}property_list_t;

typedef struct protocol_list_t {
    
}protocol_list_t;

typedef struct ivar_list_t {
    
}ivar_list_t;



struct class_rw_t {
    // Be warned that Symbolication knows the layout of this structure.
    uint32_t flags;
    uint32_t version;

    struct class_ro_t *ro; // 指向只读结构体，里面保存类的初始信息
    
    /**
     *  这三个是二维数组，可读写，里面包含了类的初始信息、分类信息
     *  二维数组中有部分信息是从class_ro_t中合并过来
     *
     *  method_array_t中存储method_list_t，method_list_t中存储method_t
     *
     *  protocol_array_t中存储protocol_list_t，protocol_list_t中存储protocol_t
     *
     *  property_array_t中存储property_list_t，property_list_t中存储property_t
     */
    method_array_t methods;
    protocol_array_t protocols;
    property_array_t properties;
    
    Class firstSubclass;
    Class nextSiblingClass;
};

struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;
    uint32_t reserved;

    const uint8_t *ivarLayout;

    const char *name;
    // With ptrauth, this is signed if it points to a small list, but
    // may be unsigned if it points to a big list.
    method_list_t *baseMethodList;
    protocol_list_t *baseProtocols;
    const ivar_list_t *ivars;

    const uint8_t *weakIvarLayout;
    property_list_t *baseProperties;
};

//
//
//
//class_rw_t* data() const {
//    return (class_rw_t *)(bits & FAST_DATA_MASK);
//}
//
//struct class_data_bits_t {
//    
//}


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
    int _age;
    NSString *_name;
    int _no;
    double _height;
    int _year;
    NSString *_name1;
    int _weight;
    NSString *_name2;
}

//@property(nonatomic, assign) int no;
//@property(nonatomic, strong) NSString *name;
//@property(nonatomic, assign) int weight;
//@property(nonatomic, strong) NSString *name1;
//@property(nonatomic, assign) int age;
//@property(nonatomic, strong) NSString *name2;
//@property(nonatomic, assign) int year;
//@property(nonatomic, assign) double height;

//@property(nonatomic, assign) int no;
//@property(nonatomic, assign) int year;
//@property(nonatomic, assign) int age;
//@property(nonatomic, assign) int weight;
//@property(nonatomic, strong) NSString *name;
//@property(nonatomic, strong) NSString *name1;
//@property(nonatomic, strong) NSString *name2;
//@property(nonatomic, assign) double height;

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.no = 10;
//        self.year = 2021;
//        self.age = 20;
//        self.weight = 130;
//        self.name = @"name";
//        self.name1 = @"name1";
//        self.name2 = @"name2";
//        self.height = 170;
    }
    return self;
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"%@ --- %@", self.name, self.name1];
//}

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
//        Person *model = [[Person alloc]init];
//        NSLog(@"%zu", class_getInstanceSize(model.class)); // 72
//        NSLog(@"%zu", malloc_size(CFBridgingRetain(model))); // 80
//
//        struct Person_IMPL *object = (__bridge struct Person_IMPL *)(model);
//        NSLog(@"no=%d-year=%d-age=%d-weight=%d-name=%@-name1=%@-name2=%@-height=%d", object -> _no, object -> _year, object -> _age, object -> _weight, object -> _name, object -> _name1, object -> _name2, object -> _weight);
        
//        Student *student = [[Student alloc]init];
//
//        struct Student_IMPL *impl = (__bridge struct Student_IMPL *)(student);
//        NSLog(@"no=%d-year=%d-age=%d-weight=%d-name=%@-name1=%@-name2=%@-height=%d", impl -> Person_IVARS._no, impl -> Person_IVARS._year, impl -> Person_IVARS._age, impl -> Person_IVARS._weight, impl -> Person_IVARS._name, impl -> Person_IVARS._name1, impl -> Person_IVARS._name2, impl -> Person_IVARS._weight);
        
//        BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
//        BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
//        BOOL re3 = [(id)[Student class] isKindOfClass:[Student class]];
//        BOOL re4 = [(id)[Student class] isMemberOfClass:[Student class]];
//        NSLog(@" re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
//
//        BOOL re5 = [(id)[NSObject alloc] isKindOfClass:[NSObject class]];
//        BOOL re6 = [(id)[NSObject alloc] isMemberOfClass:[NSObject class]];
//        BOOL re7 = [(id)[Student alloc] isKindOfClass:[Student class]];
//        BOOL re8 = [(id)[Student alloc] isMemberOfClass:[Student class]];
//        NSLog(@" re5 :%hhd\n re6 :%hhd\n re7 :%hhd\n re8 :%hhd\n",re5,re6,re7,re8);
        
    }
    return 0;
}
