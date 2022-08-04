# NSTimer

目录：

一、[NSTimer的创建方式](#NSTimer的创建方式)

二、[NSTimer常见问题](#NSTimer常见问题)

三、[NSTimer解决方案](#NSTimer解决方案)

## NSTimer的创建方式

### oc版本

```objectivec

// 方式一

self.delayTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
[[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];

self.delayTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSLog(@"handleHideTimer");
}];
[[NSRunLoop currentRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];

// 方式二

NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleHideTimer) userInfo:nil repeats:YES];
self.delayTimer = timer;
    
NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSLog(@"handleHideTimer");
}];
self.delayTimer = timer;

```
### swift版本

```swift

// 方式一
let timer = Timer.init(timeInterval: 1, target: self, selector: #selector(handleHideTimer), userInfo: nil, repeats: true)
RunLoop.current.add(timer, forMode: .common)
self.delayTimer = timer
        
let timer = Timer.init(timeInterval: 1, repeats: true) { timer in
    STLog("handleHideTimer")
}
RunLoop.current.add(timer, forMode: .common)
self.delayTimer = timer

// 方式二

let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleHideTimer), userInfo: nil, repeats: true)
delayTimer = timer
        
let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
     STLog("handleHideTimer")
}
self.delayTimer = timer
```

## NSTimer常见问题

### 一、target 循环引用问题

```
The object to which to send the message specified by aSelector when the timer fires. The timer maintains a strong reference to this object until it (the timer) is invalidated.
```
***从苹果官网上可以找到相关说明：`timer` 会一直强引用 `target`，直到 `timer invalidated`。而在当前 `self` 中又持有了 `timer`，形成了相互引用。***

也就是说，页面在销毁之前如果没有调用 `timer invalidated`, dealloc/deinit 方法不会调用。

### 二、NSTimer准确性问题

一般情况下是不准确的，原因如下：

> 1、`NSTimer` 是基于 `Runloop`，当 `Runloop` 中有其他比较多的耗时操作，且操作时间超过了 `NSTimer` 的间隔，那么这一次的 `NSTimer` 就会被延后处理。此时可以将 `NSTimer` 放入子线程，并手动开启子线程的 `Runloop` 单独处理，会相对准确一些。
>
> 2、当没有指定 `RunloopMode` 时，`Runloop` 默认会添加到 `RunLoopDefaultMode` 中，当页面有 `tableview` 滑动时，主线程的 `Runloop` 会切换到 `TrackingRunLoopMode`，此时`NSTimer` 不会被触发，导致计时不准确。将 `timer` 的 `mode` 设置为 `NSRunLoopCommonModes`可以解决`tableview` 滑动造成计时器不触发问题。

## NSTimer解决方案
