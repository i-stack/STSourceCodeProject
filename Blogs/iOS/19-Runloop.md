# Runloop简介

定义：Runloop是一个调度任务和处理任务的循环，与线程息息相关，目的是让线程在有工作的时候开始工作，没有工作的时候让线程进入休眠状态。

特点：

> Runloop与线程绑定，每条线程都有唯一一个与之对应的RunLoop对象；
> 
> 不能自己创建RunLoop对象，但是可以获取系统提供的RunLoop对象；
> 
> 主线程的RunLoop对象是由系统自动创建好的，在应用程序启动的时候会自动完成启动，而子线程中的RunLoop对象需要我们手动获取并启动；
> 
> RunLoop在线程中不断检测，通过input source和timer source接受事件，然后通知线程进行处理事件。

# Runloop底层数据结构

```
struct __CFRunLoop {
    CFRuntimeBase _base;
    //获取mode列表的锁
    pthread_mutex_t _lock;            /* locked for accessing mode list */
    //唤醒端口
    __CFPort _wakeUpPort;            // used for CFRunLoopWakeUp
    Boolean _unused;
    //重置RunLoop数据
    volatile _per_run_data *_perRunData;              // reset for runs of the run loop
    //RunLoop所对应的线程
    pthread_t _pthread;
    uint32_t _winthread;
    //标记为common的mode的集合
    CFMutableSetRef _commonModes;
    //commonMode的item集合
    CFMutableSetRef _commonModeItems;
    //当前的mode
    CFRunLoopModeRef _currentMode;
    //存储的是CFRunLoopModeRef
    CFMutableSetRef _modes;
     // _block_item链表表头指针
    struct _block_item *_blocks_head;
    // _block_item链表表尾指针
    struct _block_item *_blocks_tail;
    //运行时间点
    CFAbsoluteTime _runTime;
    //睡眠时间点
    CFAbsoluteTime _sleepTime;
    CFTypeRef _counterpart;
};
```
