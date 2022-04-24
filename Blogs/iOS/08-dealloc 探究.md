# dealloc 探究

* **dealloc**
```
- (void)dealloc {
    _objc_rootDealloc(self);
}

void _objc_rootDealloc(id obj) {
    ASSERT(obj);
    obj->rootDealloc();
}
```

* **rootDealloc**
```
inline void objc_object::rootDealloc() {
    if (isTaggedPointer()) return;  // fixme necessary?

    if (fastpath(isa.nonpointer                     &&
                 !isa.weakly_referenced             &&
                 !isa.has_assoc                     &&
#if ISA_HAS_CXX_DTOR_BIT
                 !isa.has_cxx_dtor                  &&
#else
                 !isa.getClass(false)->hasCxxDtor() &&
#endif
                 !isa.has_sidetable_rc)) {
        assert(!sidetable_present());
        free(this);
    } else {
        object_dispose((id)this);
    }
}
```

* **objc_destructInstance**
```
id object_dispose(id obj) {
    if (!obj) return nil;

    objc_destructInstance(obj);    
    free(obj);

    return nil;
}

void *objc_destructInstance(id obj) {
    if (obj) {
        // Read all of the flags at once for performance.
        bool cxx = obj->hasCxxDtor();
        bool assoc = obj->hasAssociatedObjects();

        // This order is important.
        if (cxx) object_cxxDestruct(obj);
        if (assoc) _object_remove_assocations(obj, /*deallocating*/true);
        obj->clearDeallocating();
    }

    return obj;
}

inline void objc_object::clearDeallocating() {
    if (slowpath(!isa.nonpointer)) {
        // Slow path for raw pointer isa.
        sidetable_clearDeallocating();
    } else if (slowpath(isa.weakly_referenced  ||  isa.has_sidetable_rc)) {
        // Slow path for non-pointer isa with weak refs and/or side table data.
        clearDeallocating_slow();
    }

    assert(!sidetable_present());
}

void objc_object::sidetable_clearDeallocating() {
    SideTable& table = SideTables()[this];

    // clear any weak table items
    // clear extra retain count and deallocating bit
    // (fixme warn or abort if extra retain count == 0 ?)
    table.lock();
    RefcountMap::iterator it = table.refcnts.find(this);
    if (it != table.refcnts.end()) {
        if (it->second & SIDE_TABLE_WEAKLY_REFERENCED) {
            weak_clear_no_lock(&table.weak_table, (id)this);
        }
        table.refcnts.erase(it);
    }
    table.unlock();
}
```

* **dealloc流程图**

```mermaid
graph TD

_objc_rootDealloc["objc_rootDealloc(id obj)"]
objc_rootDealloc["objc_rootDealloc(obj)"]
isTaggedPointer(判断对象是否是`taggedPointer`)
isFastPath(是否可以快速释放<br/>fastPath)
fastPath(需要同时满足以下 <br/> 对象采用了优化的isa计数方式 <br/> 对象没有被weak引用 <br/> 对象没有关联对象 <br/> 对象没有自定义的C++析构函数 <br/> 对象没有用到SideTable进行引用计数)
object_dispose["object_dispose(id obj)"]
objc_destructInstance["void *objc_destructInstance(id obj)"]
objcIsValid(obj是否存在)
isNonpointer(对象是否采用了优化的isa计数方式)

dealloc-->_objc_rootDealloc-->objc_rootDealloc-->isTaggedPointer
isTaggedPointer-->|是|return
isTaggedPointer-->|否|isFastPath
isFastPath-->|是|fastPath-->free["free(obj)"]
isFastPath-->|否|object_dispose-->objc_destructInstance-->objcIsValid
objcIsValid-->|否|返回obj
objcIsValid-->|是|条件判断

条件判断-->如果有自定义C++析构函数-->object_cxxDestruct["object_cxxDestruct(obj)"]
条件判断-->如果有关联对象-->_object_remove_assocations["_object_remove_assocations(obj, /*deallocating*/true)"]
条件判断-->clearDeallocating["obj->clearDeallocating()"]-->isNonpointer
isNonpointer-->|是|如果对象使用SideTable进行引用计数或者被weak引用-->clearDeallocating_slow
isNonpointer-->|否|sidetable_clearDeallocating
```
