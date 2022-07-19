# isKindOfClass

## - (BOOL)isKindOfClass:(Class)aClass

判断当前class对象类型是不是传入的Class类型，如果不是则判断当前class的父类对象类型是不是传入的Class类型。

```
- (BOOL)isKindOfClass:(Class)aClass {
    for (Class tcls = [self class]; tcls; tcls = tcls->getSuperClass()) {
        if (tcls == aClass) rerturn YES:
    }
    return NO:
}
```

举例：

```
STStudent *stu = [[STStudent alloc] init];

NSLog(@"%d", [stu isKindOfClass: [stu class]]);
// 结果输出为1
// 当前传入的class为： [stu class] -> STStudent
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [stu isKindOfClass: [STStudent class]]);
// 结果输出为1
// 当前传入的class为： [STStudent class] -> STStudent
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [stu isKindOfClass: [NSObject class]]);
// 结果输出为1
// 当前传入的class为： [NSObject class] -> NSObject
// 当前的class类型为： [self class] -> STStudent --> .superClass == NSObject
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1
```

## + (BOOL)isKindOfClass:(Class)aClass

判断当前类对象的元类是不是传入的Class类型，如果不是则判断当前类对象的父类对象的元类是不是传入的Class类型。

```
+ (BOOL)isKindOfClass:(Class)aClass {
    for (Class tcls = self->ISA(); tcls; tcls = tcls->getSuperClass()) {
        if (tcls == aClass) rerturn YES:
    }
    return NO:
}
```

举例：

```
STStudent *stu = [[STStudent alloc] init];

NSLog(@"%d", [STStudent isKindOfClass: [stu class]]);
// 结果输出为0
// 当前传入的class为： [stu class] -> STStudent
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前类对象的元类是不是传入的Class类型，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isKindOfClass: [STStudent class]]);
// 结果输出为0
// 当前传入的class为： [STStudent class] -> STStudent
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前类对象的元类是不是传入的Class类型，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isKindOfClass: [NSObject class]]);
// 结果输出为1
// 当前传入的class为： [NSObject class] -> NSObject
// 当前的class类型为： self->ISA() -> STStudent的元类对象 ...-> .superClass == NSObject
// 判断当前类对象的元类是不是传入的Class类型，两者是相同类型，因此输出为1

NSLog(@"%d", [STStudent isKindOfClass: object_getClass([stu class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([stu class]) -> STStudent的元类对象
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前类对象的元类是不是传入的Class类型，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isKindOfClass: object_getClass([STStudent class])]);
// 结果输出为1
// 当前传入的class为： object_getClass([STStudent class]) -> STStudent的元类对象
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前类对象的元类是不是传入的Class类型，两者是相同类型，因此输出为1
```

# isMemberOfClass

## - (BOOL)isMemberOfClass:(Class)aClass

判断当前的class是不是传入的aClass类型。

```
- (BOOL)isMemberOfClass:(Class)aClass {
    return [self class] == aClass;
}
```

举例：

```
STStudent *stu = [[STStudent alloc] init];

NSLog(@"%d", [stu isMemberOfClass: [stu class]]);
// 结果输出为1
// 当前传入的class为： [stu class] -> STStudent
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [stu isMemberOfClass: [STStudent class]]);
// 结果输出为1
// 当前传入的class为： [STStudent class] -> STStudent
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [stu isMemberOfClass: [NSObject class]]);
// 结果输出为0
// 当前传入的class为： [NSObject class] -> NSObject
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0

NSLog(@"%d", [stu isMemberOfClass: object_getClass(stu)]);
// 结果输出为1
// 当前传入的class为： object_getClass(stu) -> STStudent
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [stu isMemberOfClass: object_getClass([stu class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([stu class]) -> STStudent的元类
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0

NSLog(@"%d", [stu isMemberOfClass: object_getClass([STStudent class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([STStudent class]) -> STStudent的元类对象
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0

NSLog(@"%d", [stu isMemberOfClass: object_getClass([NSObject class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([NSObject class]) -> NSObject的元类对象
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0
```

## + (BOOL)isMemberOfClass:(Class)aClass

判断当前class的元类与传入的aClass的元类是否相同。

```
+ (BOOL)isMemberOfClass:(Class)aClass {
    return self->ISA() == aClass;
}
```

举例：

```
STStudent *stu = [[STStudent alloc] init];

NSLog(@"%d", [STStudent isMemberOfClass: [stu class]]);
// 结果输出为0
// 当前传入的class为： [stu class] -> STStudent
// 当前的class类型为： self->ISA() -> STStudent的元类
// 判断当前的class的元类与传入的aClass的元类是否相同，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isMemberOfClass: [STStudent class]]);
// 结果输出为0
// 当前传入的class为： [STStudent class] -> STStudent
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class的元类与传入的aClass的元类是否相同，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isMemberOfClass: [NSObject class]]);
// 结果输出为0
// 当前传入的class为： [NSObject class] -> NSObject
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class的元类与传入的aClass的元类是否相同，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isMemberOfClass: object_getClass(stu)]);
// 结果输出为0
// 当前传入的class为： object_getClass(stu) -> STStudent
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class的元类与传入的aClass的元类是否相同，两者是不同类型，因此输出为0

NSLog(@"%d", [STStudent isMemberOfClass: object_getClass([stu class])]);
// 结果输出为1
// 当前传入的class为： object_getClass([stu class]) -> STStudent的元类对象
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [STStudent isMemberOfClass: object_getClass([STStudent class])]);
// 结果输出为1
// 当前传入的class为： object_getClass([STStudent class]) -> STStudent的元类对象
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class是不是传入的aClass类型，两者是相同类型，因此输出为1

NSLog(@"%d", [STStudent isMemberOfClass: object_getClass([NSObject class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([NSObject class]) -> NSObject的元类对象
// 当前的class类型为： self->ISA() -> STStudent的元类对象
// 判断当前的class的元类与传入的aClass的元类是否相同，两者是不同类型，因此输出为0
```
