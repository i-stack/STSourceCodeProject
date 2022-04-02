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
    cache_t cacht;
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
