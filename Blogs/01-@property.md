# iOS 属性 @property 探究

### 代码规范

声明 `@property` 时，注意关键词及字符间的空格。

> @property (nonatomic, copy) NSString *name;
> 
> @property (nonatomic, copy, readonly) NSString *name;

### @property 本质

`@property` 的本质是：`ivar` (实例变量) + `getter` + `setter` ；

### 存取器方法

```
- (void)setName:(NSString *)name;
- (NSString *)name;

// 使用系统默认getter/setter方法
@property (nonatomic, assign) NSInteger age;

// 指定getter访问名为`isHappy`
@property (nonatomic, assign, getter=isHappy) BOOL happy;

// 指定setter方法名为`setNickName:`
@property (nonatomic, copy, setter=setNickName:) NSString *name;
```
### 读写权限

> readonly: 表示只生成 `getter` ，不生成 `setter` ，即只可读，不可以修改。
> 
> readwrite: 表示自动生成对应的 `getter` 和 `setter` 方法，即可读可写权限， `readwrite`是编译器的默认选项。

### 内存管理

* **strong**

表示强引用类型，修饰对象的引用计数会+1，通常用来修饰对象类型。

* **retain**

retain 在 MRC 下使用，表示强引用类型，修饰对象的引用计数会+1，通常用来修饰对象类型。

ARC 使用 `strong` 代替。

* **assign**

不会改变修饰对象的引用计数，通常用来修饰基础数据类型（ `NSInteger, CGFloat, Bool, NSTimeInterval`等），内存在栈上由系统自动回收。

`assign` 也用来修饰 `NSObject`类型对象时，当修饰对象销毁的时候，对象指针不会被自动清空。而此时对象指针指向的地址已被销毁，这时再访问该属性会产生野指针错误`:EXC_BAD_ACCESS`。

* **copy**

拷贝的目的: 产生一个副本对象，与源对象互不影响。

> 浅拷贝：指针拷贝，不产生新的对象，源对象的引用计数器+1；
> 
> 深拷贝：对象拷贝，会产生新的对象，源对象的引用计数器不变；

- 对可变对象进行copy和mutableCopy都是深拷贝；

- 对不可变对象进行copy是浅拷贝，mutableCopy是深拷贝；

- copy方法返回的对象都是不可变对象；

- mutableCopy返回的对象都是可变对象；

- 集合中的元素不管是copy还是mutableCopy，其内部元素地址都是浅拷贝。

* **自定义对象实现拷贝**

> 自定义类遵守 `<NSCopying, NSMutableCopying>`协议；
> 
> 重写 copyWithZone: 和 mutableCopyWithZone: 两个方法；
> 
> 自定义对象实现copy和mutableCopy都是深拷贝。

* **完全深拷贝**

> initWithArray:copyItems:YES;
> 
> 使用归档和解档来实现对象的完全深拷贝;

* **weak**

表示弱引用关系，修饰对象的引用计数不会增加，当修饰对象被销毁的时候，对象指针会自动置为 `nil`，防止出现野指针。`weak` 也用来修饰 `delegate` ，避免循环引用。另外 `weak` 只能用来修饰对象类型，且是在 `ARC` 下新引入的修饰词，`MRC` 下相当于使用 `assign` 。

**weak的底层实现原理**
