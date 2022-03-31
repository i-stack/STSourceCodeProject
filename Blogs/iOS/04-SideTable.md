# iOS SideTable 探究

### SideTable

* **SideTable就是一个哈希表**

> 哈希表（hash table）又叫散列表，是一种数据结构，用来存放数据

* **SideTable**

```
struct SideTable {
    /**
     *  typedef mutex_t spinlock_t;
     **/
    spinlock_t slock;
    
    // 引用计数表
    RefcountMap refcnts;
    
    // 弱引用表，hash表
    weak_table_t weak_table;

    SideTable() {
        memset(&weak_table, 0, sizeof(weak_table));
    }

    ~SideTable() {
        // 不能删除SideTable
        _objc_fatal("Do not delete SideTable.");
    }

    // 锁住
    void lock() { slock.lock(); }
    void unlock() { slock.unlock(); }
    
    // 重新设置锁
    void forceReset() { slock.forceReset(); }

    // Address-ordered lock discipline for a pair of side tables.

    template<HaveOld, HaveNew>
    static void lockTwo(SideTable *lock1, SideTable *lock2);
    template<HaveOld, HaveNew>
    static void unlockTwo(SideTable *lock1, SideTable *lock2);
};

// 返回内存对齐后的SideTable指针
alignas(StripedMap<SideTable>) static uint8_t 
    SideTableBuf[sizeof(StripedMap<SideTable>)];

// 初始化SideTable
static void SideTableInit() {
    new (SideTableBuf) StripedMap<SideTable>();
}


// 获取SideTable数组
static StripedMap<SideTable>& SideTables() {
    return *reinterpret_cast<StripedMap<SideTable>*>(SideTableBuf);
}
```
* **RefcountMap**

* **weak_table_t**
```
/**
 * The global weak references table. Stores object ids as keys,
 * and weak_entry_t structs as their values.
 */
struct weak_table_t {
    weak_entry_t *weak_entries;
    size_t    num_entries;
    uintptr_t mask;
    uintptr_t max_hash_displacement;
};

```
