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
```
- 对可变对象进行copy和mutableCopy都是深拷贝；

- 对不可变对象进行copy是浅拷贝，mutableCopy是深拷贝；

- copy方法返回的对象都是不可变对象；

- mutableCopy返回的对象都是可变对象；

- 集合中的元素不管是copy还是mutableCopy，其内部元素地址都是浅拷贝。
```
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

> 表示弱引用关系，所引用对象的计数器不会加1，并在引用对象被释放的时候自动被设置为 nil。
> 
> `weak` 只能用来修饰对象类型，且是在 `ARC` 下新引入的修饰词，`MRC` 下相当于使用 `assign`。

**weak的底层实现原理**

> Runtime维护了一个弱引用表，将所有弱引用obj的指针地址都保存在obj对应的weak_entry_t中;
> 
> 创建时，先从找到全局散列表SideTables中对应的弱引用表weak_table;
> 
> 在weak_table中被弱引用对象的referent,并创建或者插入对应的weak_entry_t;
> 
> 然后append_referrer(entry, referrer)将我的新弱引⽤的对象加进去entry;
> 
> 最后weak_entry_insert 把entry加⼊到我们的weak_table。

* ***weak_table_t底层结构***

<img width="718" alt="The qlobal weak references table  Stores obiect ids as keys," src="https://user-images.githubusercontent.com/4375433/160064307-a73bcbae-b936-4253-adac-62e81303c9e0.png">

> weak_entry_t *weak_entries; // 存储 weak 对象信息的 hash 数组
> 
> size_t num_entries; // 数组中元素的个数
> 
> uintptr_t mask; 
> 
> uintptr_t max_hash_displacement; // hash 元素最大偏移值

* ***weak_entry_t底层结构***

```
#define WEAK_INLINE_COUNT 4
#define REFERRERS_OUT_OF_LINE 2

struct weak_entry_t {
    DisguisedPtr<objc_object> referent;
    union {
        struct {
            weak_referrer_t *referrers; // 弱引用该对象的对象指针的hash数组
            uintptr_t        out_of_line_ness : 2;
            uintptr_t        num_refs : PTR_MINUS_2;
            uintptr_t        mask;
            uintptr_t        max_hash_displacement;
        };
        // 定长数组，最大值为4，苹果考虑到一半弱引用的指针个数不会超过这个数，因此为了提升运行效率，一次分配一整块的连续内存空间
        struct {
            // out_of_line_ness field is low bits of inline_referrers[1]
            weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
        };
    };

    // 判断当前是动态数组，还是定长数组
    bool out_of_line() {
        return (out_of_line_ness == REFERRERS_OUT_OF_LINE);
    }

    weak_entry_t& operator=(const weak_entry_t& other) {
        memcpy(this, &other, sizeof(other));
        return *this;
    }

    weak_entry_t(objc_object *newReferent, objc_object **newReferrer)
        : referent(newReferent)
    {
        inline_referrers[0] = newReferrer;
        for (int i = 1; i < WEAK_INLINE_COUNT; i++) {
            inline_referrers[i] = nil;
        }
    }
};
```
> 定长数组到动态数组的切换，首先会将原来定长数组中的内容转移到动态数组中，然后再在动态数组中插入新的元素。
> 
> 而对于动态数组中元素个数大于或等于总空间的 3/4 时，会对动态数组进行总空间 * 2 的扩容。

* ***weak调用流程***

<img width="728" alt="weak_entry foe referent" src="https://user-images.githubusercontent.com/4375433/160074921-798f5921-234b-48eb-b8e7-38155bbb5a00.png">

* ****objc_initWeak****

<img width="768" alt="oparam location Address of weak ptr" src="https://user-images.githubusercontent.com/4375433/160075075-2fa35d07-ac42-4833-b3b9-43496403f610.png">

* ****storeWeak****

<img width="1112" alt="(have0id)" src="https://user-images.githubusercontent.com/4375433/160075265-8e2a7262-02ee-4959-8db6-dbe230d6f384.png">

* ****weak_unregister_no_lock****

<img width="749" alt="Gparam weak table The qloba1 weak table" src="https://user-images.githubusercontent.com/4375433/160075388-1da4fc2c-00e2-4bee-8f7b-8678be7c2490.png">

* ****weak_register_no_lock****

<img width="1029" alt="Reoisters a nen (obJeoty weak pointer) oair  Creates a new weak" src="https://user-images.githubusercontent.com/4375433/160075462-7863f00c-335e-4c61-8ade-bd3e963c694a.png">

* ***weak销毁流程***

![dealloc](https://user-images.githubusercontent.com/4375433/160075549-b0e9e431-b341-42e7-8b3d-4c7bae98c1ba.png)

* **nonatomic、atomic**

****setter方法****

```
void objc_setProperty_atomic(id self, SEL _cmd, id newValue, ptrdiff_t offset) {
    reallySetProperty(self, _cmd, newValue, offset, true, false, false);
}

void objc_setProperty_nonatomic(id self, SEL _cmd, id newValue, ptrdiff_t offset) {
    reallySetProperty(self, _cmd, newValue, offset, false, false, false);
}

```

****reallySetProperty****

![tle Inline veid reallysatProserty(ld self  stu-cad  1d mewvalue  ptralrf-t efrset, tool atoele, boal caev  tool](https://user-images.githubusercontent.com/4375433/160108697-dcafadcc-7399-4a83-ae84-bcd84de72c88.png)

****getter方法****

![1d cbjc_getProperty(id self SEL cnd, ptrdifft offset, Bo0L atonic)](https://user-images.githubusercontent.com/4375433/160108832-b4e96354-253d-4f37-a17a-df67fc7c2871.png)
