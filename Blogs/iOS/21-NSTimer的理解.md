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
> 1、使用方式二创建的定时器会自动添加到当前的 `runloop` 中去，使用方式一创建的定时器需要手动添加到` runloop` 中并指定 `mode `。
> 
> 2、使用block方式创建的定时器不会有 `timer` 强引用问题，但需要主要 `block` 的循环引用问题。

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

### 方式一

在页面将要销毁之前调用 `timer invalidated`，可避免因为 `timer` 与 `self` 之间的强引用导致内存泄露。

### 方式二

使用带 `block` 的 `API` 创建定时器，没有`timer` 与 `self` 之间的强引用问题，但需要注意 `block` 引起的循环引用问题。

### 方式三

使用中间件方式，进行消息转发，这里有两种：一种继承 NSObject，一种继承 NSProxy。

NSObject 方式：oc、swift

```swift

public class STTimer: NSObject {

    private weak var target: AnyObject?

    public init(aTarget: AnyObject) {
        super.init()
        self.target = aTarget
    }

    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return self.target
    }
}
```

在使用定时器的地方：

```swift
self.aTarget = STTimer.init(aTarget: self)
let timer = Timer.scheduledTimer(timeInterval: 1, target: self.aTarget ?? nil, selector: #selector(handleHideTimer), userInfo: nil, repeats: true)
self.delayTimer = timer
```
NSProxy 方式：oc

```objectivec
@interface STProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end

#import "STProxy.h"

@interface STProxy ()

@property (nonatomic, weak)id target;

@end

@implementation STProxy

+ (instancetype)proxyWithTarget:(id)target {
    STProxy *proxy = [STProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
```
> 1、swift 不能使用 NSProxy 进行转发，NS_SWIFT_UNAVAILABLE("NSInvocation and related APIs not available")
> 
> 2、NSProxy 转发比进行消息转发快，因为消息转发流程先进行快速查找，然后进行慢查找，最后进入消息转发流程；而 NSProxy 直接进入消息转发流程的第三阶段。

### 方式四

使用GCD方式

```swift
public class STTimerGCD {
    
    private static var timerDict: [String: DispatchSourceTimer] = [String: DispatchSourceTimer]()
    private static let semaphore = DispatchSemaphore.init(value: 1)

    @discardableResult
    public class func st_scheduledTimer(withTimeInterval interval: Int, repeats: Bool, async: Bool, block: @escaping (String) -> Void) -> String {
        self.st_scheduledTimer(afterDelay: 0, withTimeInterval: interval, repeats: repeats, async: async, block: block)
    }
    
    @discardableResult
    public class func st_scheduledTimer(afterDelay: Int, withTimeInterval interval: Int, repeats: Bool, async: Bool, block: @escaping (String) -> Void) -> String {
        if interval <= 0, repeats == true { return "" }
       
        let queue = async ? DispatchQueue.global() : DispatchQueue.main
        let timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: queue)
        
        self.semaphore.wait()
        let name = timer.description
        self.timerDict[name] = timer
        self.semaphore.signal()
        timer.schedule(deadline: .now() + Double(afterDelay), repeating: .seconds(interval))
        timer.setEventHandler {
            DispatchQueue.main.async {
                block(name)
                if !repeats {
                    self.st_cancelTask(name: name)
                }
            }
        }
        timer.resume()
        return name
    }
    
    public class func st_cancelTask(name: String) {
        if name.count > 0 {
            self.semaphore.wait()
            if let timer = self.timerDict[name] {
                timer.cancel()
                self.timerDict.removeValue(forKey: name)
            }
            self.semaphore.signal()
        }
    }
}
```
