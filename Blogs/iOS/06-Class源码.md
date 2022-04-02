# iOS Class 源码探究

> typedef struct objc_class *Class;

* **objc_object**

```
struct objc_object {
    void *isa;
};
```
* **objc_class**

```
struct objc_class: objc_object {
    Class superClass;
    cache_t cache;
    class_data_bits_t bits;
public:
    class_rw_t *data() {
        return bits.data();
    }
    
    objc_class *metaClass() {
        return (objc_class *)((long long)isa & ISA_MASK);
    }
}
```
> superClass, 当前class的父类
> 
> cache 缓存
> 
> class_data_bits_t 保存着类的信息

* **class_data_bits_t**

```
#define FAST_DATA_MASK 0x00007ffffffffff8UL

struct class_data_bits {
    uintptr_t bits;
public:
    class_rw_t *data() {
        return (class_rw_t *)(bits & FAST_DATA_MASK);
    }
}
```
> class_data_bits主要功能是得到calss_rw_t。

* **class_rw_t**
```
struct class_rw_t {
    uint32_t flags;
    uint32_t version;
    const class_ro_t *ro;
    method_list_t *methods; // 方法列表
    property_list_t *properties; // 属性列表
    const protocol_list_t *protocols; // 协议列表
    Class firstSubclass;
    Class nextSiblingClass;
    char *demangledName;
}
```
* **class_ro_t**
```
struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;  // instance对象占用的内存空间
#ifdef __LP64__
    uint32_t reserved;
#endif
    const uint8_t * ivarLayout;
    const char * name;  // 类名
    method_list_t * baseMethodList;
    protocol_list_t * baseProtocols;
    const ivar_list_t * ivars;  // 成员变量列表
    const uint8_t * weakIvarLayout;
    property_list_t *baseProperties;
};
```
