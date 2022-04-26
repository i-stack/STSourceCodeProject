# self

> 类的隐藏参数，指向当前调用方法的类的实例
> 
> `objc_msgSend(id receiver, SEL _cmd, ...)`

* **[self class]调用流程**

> `self` 指向当前调用方法的类的实例，根据类的 `isa` 指针找到当前对象所在类
> 
> 消息转发流程

# super

> 指向 `objc_super` 结构体的指针
> 
> `objc_msgSendSuper(struct objc_super *super, SEL _cmd, ...)`
> 
> 查找方法时会先从父类开始进行查找

```
struct objc_super {
  id receiver; // 当前类
  Class superClass; // 指向当前类父类
}
```

* **[super class]调用流程**

> 从 `superClass` 类中开始查找
> 
> 消息转发流程
> 
> 如果找到，使用 `receiver` 调用
