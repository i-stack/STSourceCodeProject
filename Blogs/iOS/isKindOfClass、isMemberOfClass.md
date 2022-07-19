# isKindOfClass

```
- (BOOL)

```

# isMemberOfClass

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
// 当前传入的class为： object_getClass([STStudent class]) -> STStudent的元类
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0

NSLog(@"%d", [stu isMemberOfClass: object_getClass([NSObject class])]);
// 结果输出为0
// 当前传入的class为： object_getClass([NSObject class]) -> NSObject的元类
// 当前的class类型为： [self class] -> STStudent
// 判断当前的class是不是传入的aClass类型，两者是不同类型，因此输出为0

```
