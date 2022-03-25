# iOS 内存管理 探究

### 内存管理

* **iOS下内存管理的基本思想就是引用计数，通过对象的引用计数来对对象的生命周期进行管理，主要有两种方式：**

> MRR(manual retail-relesae)，手动管理对象的生命周期；
> 
> ARC(Automatic Reference Counting)，自动引用计数，由系统进行管理对象的生命周期；

* **内存管理面临的问题：**

> 释放或者覆盖的数据仍在在使用，将造成崩溃；
> 
> 不释放不在使用的对象会导致内存泄露。

### 内存管理规则

一个对象至少有一个所有者，它会继续存在；如果对象没有所有者时，那么运行时系统会自动销毁它。

> 1、使用***alloc、new、copy、mutableCopy***等创建的对象；它的引用计数为1；
> 
> 2、使用***retain***保留一个对象；它的引用计数+1；
> 
> 3、当向一个对象发送***release***消息，它的引用计数-1；
> 
> 4、当向一个对象发送***autorelease***消失，它的引用计数在当前***autorelease pool block***结束的时候-1；
> 
> 5、如果一个***对象的引用计数为0，它会被销毁***；
> 
> 6、当向集合类（array、dictionary、set）中添加一个对象时，集合会拥有这个对象；
> 
> 7、当对象从集合中移除或者集合本身被释放时，会立即给对象发送release消息，对象会被立即释放；
> 
> 8、如果释放父类对象，那么相关的子类对象也会被释放。

### Use Weak References to Avoid Retain Cycles

Cocoa中弱引用包含但不仅限于：table data sources、outline view items、notification observers、delegates。

### 内存中的五大区域

* **栈区(stack)**

> 由***高地址***向***低地址***拓展的数据结构；
> 
> 由编译器自动分配并释放，存放函数的***参数值，局部变量***等；
> 
> 栈区一般在运行时进行分配，栈的地址空间在iOS中通常以0x7开头；是一块连续内存，遵循***先进后出***的原则；
> 
> 优点是***高效的读写速度，不会产生内存碎片***；缺点是***栈内存较小（iOS主线程栈大小1MB，其他线程512KB），储存数据不灵活***。

* **堆区(heap)**

> 由***低地址***向***高地址***拓展的数据结构；
> 
> 由程序员分配释放，若程序员不释放，会出现内存泄漏等；
> 
> 堆区一般在运行时进行分配，堆的地址空间在iOS中通常以0x6开头；是一块不连续内存，遵循***先进先出***的原则；
> 
> 优点是灵活方便；缺点是内存需要手动管理，容易产生碎片，读取速度比栈区慢；访问堆区内存时，一般是先通过对象读取到对象所在的栈区的指针地址，然后通过指针地址访问堆区。

* **代码区**

> 编译器分配，主要用于存放程序运行的代码，代码会被编译成二进制存进内存中 ；
> 
> 程序结束时系统会自动回收存储在代码段中的数据。

* **全局区、静态区、BSS 段 （Block Started by Symbol）**

> 储存***未初始化的全局变量，静态变量***；
> 
> 编译器分配内存空间，地址空间在iOS中通常以0x1开头；
> 
> 在程序运行过程中就该数据就一直存在，程序结束后由系统释放；
> 
> 全局变量或者静态变量一旦被初始化后，就会被回收，并将数据转存到常量区。

* **数据段**

> 储存***已经初始化的全局变量，静态变量，常量***；
> 
> 程序结束才会被回收。

![Pasted Graphic](https://user-images.githubusercontent.com/4375433/160082404-673c8535-ed54-49f7-a71f-720a224ff8bb.png)

### autorelease

自动释放池的主要底层数据结构是：__AtAutoreleasePool、AutoreleasePoolPage。

```
@autoreleasepool {
    // __AtAutoreleasePool __autoreleasepool;
}
```
***底层源码***

<img width="674" alt="structAtAutoreleasePool{" src="https://user-images.githubusercontent.com/4375433/160104016-0f79807b-6757-4acc-a6c8-5a746f892f4d.png">

* ***系统加载call_load_methods时会初始化AutoreleasePool***

<img width="889" alt="static bool 1oading  NO" src="https://user-images.githubusercontent.com/4375433/160104262-db652bf6-2401-42a3-a6be-e3475e1ebf55.png">

* ***objc_autoreleasePoolPush***

```
void *objc_autoreleasePoolPush(void) {
    return AutoreleasePoolPage::push();
}
```
autorelease的对象最后都是通过AutoreleasePoolPage来管理。

* ***AutoreleasePoolPage***

```
class AutoreleasePoolPage {
    magic_t const magic; 
    id *next;
    pthread_t const thread;
    AutoreleasePoolPage *const parent;
    AutoreleasePoolPage *child;
    uint32_t const depth;
    uint32_t hiwat;
}
```
> ***AutoreleasePoolPage***是一个双向链表；
> 
> ***next*** 指向了下一个能存放autorelease对象地址的区域；
> 
> ***begin()*** 是当前page的初始地址 + page成员变量的大小；
> 
> ***end()*** 是当前page的初始地址 + 4096；
> 
> 每个***AutoreleasePoolPage***对象占用4096字节内存，除了用来存放它内部的成员变量，剩余空间用来存放autorelease对象的地址；

* ***AutoreleasePoolPage::push()***

<img width="971" alt="static inlino void apush()" src="https://user-images.githubusercontent.com/4375433/160106278-b20cf295-0a6c-4c1e-903d-6517c789176a.png">

* ***AutoreleasePoolPage::pop()***

```
void *objc_autoreleasePoolPop(void) {
    return AutoreleasePoolPage::pop();
}
```

<img width="806" alt="void releaseuntil(id stop)" src="https://user-images.githubusercontent.com/4375433/160106346-431a998c-dc84-455e-a910-66b221402427.png">

> 调用push方法会将一个***POOL_BOUNDARY***入栈，返回其存放的内存地址；
> 
> 调用pop方法时传入push返回的***POOL_BOUNDARY***的内存地址，会从最后一个入栈的对象开始发送release消息，直到遇到这个***POOL_BOUNDARY***。
