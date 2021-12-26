//
//  STStudent.m
//  STAlgorithmProject
//
//  Created by song on 2021/11/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STStudent.h"
#import <objc/runtime.h>
#import "NSObject+STRuntime.h"

@implementation STStudent

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *json = @{@"name":@"张三", @"address":@"bj", @"count":@"bj"};
        STPerson *person = [STPerson st_jsonToModel:json];
        NSLog(@"%@", person);
    }
    return self;
}

- (void)getAllInstance {
    unsigned int count;
    Ivar *valList = class_copyIvarList([STPerson class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = valList[i];
        NSLog(@"%s - %s", ivar_getName(var), ivar_getTypeEncoding(var));
    }
    
}

- (void)printIsKindOfClassClassMethod {
    /**
     *  + (BOOL)isKindOfClass: (Class)aClass {
     *      // 判断传入的cls，是不是当前对象metaClass
     *      // 如果不是，则到metaClass的superClass中查找，直到基类的metaClass
     *      // 基类的metaClass的superClass指向NSObject
     *      for (Class tcls = self->ISA(); tcls; tcls = tcls->getSuperclass()) {
     *          if (tcls == cls) return YES;
     *      }
     *      return NO;
     *  }
     */
    STStudent *sudent = [[STStudent alloc]init];
    
    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [STStudent isKindOfClass:[sudent class]]);

    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [STStudent isKindOfClass:[STStudent class]]);

    // STStudentMeta == STPerson 输出0
    NSLog(@"%d", [STStudent isKindOfClass:[STPerson class]]);

    // STStudentMeta == NSObject
    // STStudent->superClass... == NSObject 输出1
    NSLog(@"%d", [STStudent isKindOfClass:[NSObject class]]);

    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [STStudent isKindOfClass:object_getClass(sudent)]);

    // STStudentMeta == STStudentMeta 输出1
    NSLog(@"%d", [STStudent isKindOfClass:object_getClass([sudent class])]);

    // STStudentMeta == STStudentMeta 输出1
    NSLog(@"%d", [STStudent isKindOfClass:object_getClass([STStudent class])]);

    // STStudentMeta == STPersonMeta
    // (STStudent->superClass == STPersonMeta) == STPersonMeta 输出1
    NSLog(@"%d", [STStudent isKindOfClass:object_getClass([STPerson class])]);

    // STStudentMeta = NSObjectMeta
    // STStudent->superClass... == NSObjectMeta 输出1
    NSLog(@"%d", [STStudent isKindOfClass:object_getClass([NSObject class])]);
}

- (void)printIsKindOfClassInstanceMethod {
    /**
     *  - (BOOL)isKindOfClass: (Class)aClass {
     *      // 判断传入的cls，是不是当前对象的isa指向class
     *      // 如果不是，则到class的superClass中查找，直到基类的class
     *      for (Class tcls = [self class]; tcls; tcls = tcls->getSuperclass()) {
     *          if (tcls == cls) return YES;
     *      }
     *      return NO;
     *  }
     */
    STStudent *sudent = [[STStudent alloc]init];
    
    // [sudent class] == [sudent class]
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isKindOfClass:[sudent class]]);

    // [sudent class] == STStudent
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isKindOfClass:[STStudent class]]);

    // [sudent class] == STPerson
    // STStudent == STPerson
    // STStudent->superClass == STPerson 输出1
    NSLog(@"%d", [sudent isKindOfClass:[STPerson class]]);

    // [sudent class] == NSObject
    // STStudent == NSObject
    // STStudent->superClass... == NSObject 输出1
    NSLog(@"%d", [sudent isKindOfClass:[NSObject class]]);

    // [sudent class] == STStudent
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isKindOfClass:object_getClass(sudent)]);

    // [sudent class] == STStudentMeta
    // STStudent == STStudentMeta 输出0
    NSLog(@"%d", [sudent isKindOfClass:object_getClass([sudent class])]);

    // [sudent class] == STStudentMeta
    // STStudent == STStudentMeta 输出0
    NSLog(@"%d", [sudent isKindOfClass:object_getClass([STStudent class])]);

    // [sudent class] == STPersonMeta
    // STStudent == STPersonMeta 输出0
    NSLog(@"%d", [sudent isKindOfClass:object_getClass([STPerson class])]);

    // [sudent class] == NSObjectMeta
    // STStudent == NSObjectMeta 输出0
    NSLog(@"%d", [sudent isKindOfClass:object_getClass([NSObject class])]);
}

- (void)printIsMemberOfClassInstanceMethod {
    /**
     *  - (BOOL)isMemberOfClass: (Class)aClass {
     *      // 判断当前的class是不是传入的class类型
     *      return [self class] == cls;
     *  }
     */
    STStudent *sudent = [[STStudent alloc]init];

    // [student class] == [student class]
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isMemberOfClass:[sudent class]]);

    // [student class] == STStudent
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isMemberOfClass:[STStudent class]]);

    // [student class] == STPerson
    // STStudent == STPerson 输出0
    NSLog(@"%d", [sudent isMemberOfClass:[STPerson class]]);

    // [student class] == NSObject
    // STStudent == NSObject 输出0
    NSLog(@"%d", [sudent isMemberOfClass:[NSObject class]]);

    // [student class] == STStudent
    // STStudent == STStudent 输出1
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass(sudent)]);

    // [student class] == object_getClass(STStudent)
    // [student class] == STStudentMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([sudent class])]);

    // [student class] == object_getClass(STStudent)
    // [student class] == STStudentMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([STStudent class])]);

    // [student class] == object_getClass(STPerson)
    // [student class] == STPersonMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([STPerson class])]);

    // [student class] == object_getClass(NSObject)
    // [student class] == NSObjectMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([NSObject class])]);
}

- (void)printIsMemberOfClassClassMethod {
    /**
     *  + (BOOL)isMemberOfClass: (Class)aClass {
     *      // 判断当前类对象的元类，是不是就是传入的元类对象cls
     *      return self->ISA() == cls;
     *  }
     */
    STStudent *sudent = [[STStudent alloc]init];

    // STStudentMeta == [student class]
    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [STStudent isMemberOfClass:[sudent class]]);

    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [STStudent isMemberOfClass:[STStudent class]]);

    // STStudentMeta == STPerson 输出0
    NSLog(@"%d", [STStudent isMemberOfClass:[STPerson class]]);

    // STStudentMeta == NSObject 输出0
    NSLog(@"%d", [STStudent isMemberOfClass:[NSObject class]]);

    // STStudentMeta == STStudent 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass(sudent)]);

    // STStudentMeta == object_getClass(STStudent)
    // STStudentMeta == STStudentMeta 输出1
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([sudent class])]);

    // STStudentMeta == object_getClass(STStudent)
    // STStudentMeta == STStudentMeta 输出1
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([STStudent class])]);

    // STStudentMeta == object_getClass(STPerson)
    // STStudentMeta == STPersonMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([STPerson class])]);

    // STStudentMeta == object_getClass(NSObject)
    // STStudentMeta == NSObjectMeta 输出0
    NSLog(@"%d", [sudent isMemberOfClass:object_getClass([NSObject class])]);
}

- (void)printClass {
    NSLog(@"self class: %@", [self class]); // STStudent
    NSLog(@"super class: %@", [super class]); // STStudent
    NSLog(@"self superclass: %@", [self superclass]); // STPerson
    NSLog(@"super superclass: %@", [super superclass]); // STPerson
}

@end
